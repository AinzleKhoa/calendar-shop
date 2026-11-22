using CalendarShop.Api.Dtos;

namespace CalendarShop.Api.Services;

public class ImageStorageService : IImageStorageService
{
    private static readonly HashSet<string> AllowedExtensions = new(StringComparer.OrdinalIgnoreCase)
    {
        ".jpg",
        ".jpeg",
        ".png",
        ".webp",
        ".gif"
    };

    private const long MaxImageSizeBytes = 5 * 1024 * 1024;
    private readonly IWebHostEnvironment _environment;

    public ImageStorageService(IWebHostEnvironment environment)
    {
        _environment = environment;
    }

    public async Task<ImageUploadResultDto> SaveImageAsync(IFormFile file, CancellationToken cancellationToken = default)
    {
        if (file.Length == 0)
        {
            throw new BadHttpRequestException("Vui lòng chọn một ảnh để tải lên.");
        }

        if (file.Length > MaxImageSizeBytes)
        {
            throw new BadHttpRequestException("Ảnh tải lên không được vượt quá 5MB.");
        }

        var extension = Path.GetExtension(file.FileName);
        if (!AllowedExtensions.Contains(extension))
        {
            throw new BadHttpRequestException("Định dạng ảnh không hợp lệ. Chỉ hỗ trợ JPG, PNG, WEBP hoặc GIF.");
        }

        var webRootPath = _environment.WebRootPath;
        if (string.IsNullOrWhiteSpace(webRootPath))
        {
            webRootPath = Path.Combine(_environment.ContentRootPath, "wwwroot");
        }

        var uploadFolder = Path.Combine(webRootPath, "images", "uploads");
        Directory.CreateDirectory(uploadFolder);

        var fileName = $"{Guid.NewGuid():N}{extension.ToLowerInvariant()}";
        var filePath = Path.Combine(uploadFolder, fileName);

        await using var stream = File.Create(filePath);
        await file.CopyToAsync(stream, cancellationToken);

        return new ImageUploadResultDto($"/images/uploads/{fileName}");
    }
}
