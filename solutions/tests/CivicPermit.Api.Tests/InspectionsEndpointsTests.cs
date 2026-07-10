using System.Net;
using System.Net.Http.Json;
using CivicPermit.Api.Models;
using Microsoft.AspNetCore.Mvc.Testing;

namespace CivicPermit.Api.Tests;

/// <summary>
/// Tests for POST /permits/{id}/inspections — the workshop feature.
/// </summary>
public class InspectionsEndpointsTests : IClassFixture<WebApplicationFactory<Program>>
{
    private readonly WebApplicationFactory<Program> _factory;

    public InspectionsEndpointsTests(WebApplicationFactory<Program> factory) => _factory = factory;

    [Fact]
    public async Task Post_Inspection_ForExistingPermit_ReturnsCreated()
    {
        var client = _factory.CreateClient();
        var request = new ScheduleInspectionRequest("Framing", new DateOnly(2026, 8, 15));

        var response = await client.PostAsJsonAsync("/permits/1/inspections", request);

        Assert.Equal(HttpStatusCode.Created, response.StatusCode);
        var inspection = await response.Content.ReadFromJsonAsync<Inspection>();
        Assert.NotNull(inspection);
        Assert.Equal(1, inspection!.PermitId);
        Assert.Equal("Framing", inspection.InspectionType);
        Assert.Equal("Scheduled", inspection.Status);
    }

    [Fact]
    public async Task Post_Inspection_ForUnknownPermit_Returns404()
    {
        var client = _factory.CreateClient();
        var request = new ScheduleInspectionRequest("Final", new DateOnly(2026, 8, 20));

        var response = await client.PostAsJsonAsync("/permits/9999/inspections", request);

        Assert.Equal(HttpStatusCode.NotFound, response.StatusCode);
    }

    [Fact]
    public async Task Post_Inspection_WithMissingFields_Returns400()
    {
        var client = _factory.CreateClient();
        var request = new ScheduleInspectionRequest("", default);

        var response = await client.PostAsJsonAsync("/permits/1/inspections", request);

        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
    }
}
