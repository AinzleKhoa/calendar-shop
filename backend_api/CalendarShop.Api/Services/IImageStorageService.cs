using CalendarShop.Api.Dtos;

namespace CalendarShop.Api.Services;

public interface IImageStorageService
{
    Task<ImageUploadResultDto> SaveImageAsync(IFormFile file, CancellationToken cancellationToken = default);
}
