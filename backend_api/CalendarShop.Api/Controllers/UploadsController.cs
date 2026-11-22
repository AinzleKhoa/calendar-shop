using CalendarShop.Api.Dtos;
using CalendarShop.Api.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace CalendarShop.Api.Controllers;

[Authorize]
public class UploadsController : AppControllerBase
{
    private readonly IImageStorageService _imageStorageService;

    public UploadsController(IImageStorageService imageStorageService)
    {
        _imageStorageService = imageStorageService;
    }

    [HttpPost("images")]
    [RequestSizeLimit(5 * 1024 * 1024)]
    public async Task<ActionResult<ImageUploadResultDto>> UploadImage([FromForm] IFormFile file, CancellationToken cancellationToken)
    {
        var result = await _imageStorageService.SaveImageAsync(file, cancellationToken);
        return Ok(result);
    }
}
