using System.Net;
using System.Net.Http.Json;
using CivicPermit.Api.Models;
using Microsoft.AspNetCore.Mvc.Testing;

namespace CivicPermit.Api.Tests;

/// <summary>
/// Integration tests for the existing permit endpoints. These ship green so
/// learners start from a passing build. Lab 2.2 adds a test for the new
/// "schedule an inspection" endpoint.
/// </summary>
public class PermitsEndpointsTests : IClassFixture<WebApplicationFactory<Program>>
{
    private readonly WebApplicationFactory<Program> _factory;

    public PermitsEndpointsTests(WebApplicationFactory<Program> factory) => _factory = factory;

    [Fact]
    public async Task Get_Permits_ReturnsSeededPermits()
    {
        var client = _factory.CreateClient();

        var permits = await client.GetFromJsonAsync<List<Permit>>("/permits");

        Assert.NotNull(permits);
        Assert.NotEmpty(permits!);
    }

    [Fact]
    public async Task Get_Permit_ByKnownId_ReturnsPermit()
    {
        var client = _factory.CreateClient();

        var response = await client.GetAsync("/permits/1");

        response.EnsureSuccessStatusCode();
        var permit = await response.Content.ReadFromJsonAsync<Permit>();
        Assert.NotNull(permit);
        Assert.Equal(1, permit!.Id);
    }

    [Fact]
    public async Task Get_Permit_ByUnknownId_Returns404()
    {
        var client = _factory.CreateClient();

        var response = await client.GetAsync("/permits/9999");

        Assert.Equal(HttpStatusCode.NotFound, response.StatusCode);
    }

    [Fact]
    public async Task Post_Permit_CreatesAndReturnsPermit()
    {
        var client = _factory.CreateClient();
        var request = new CreatePermitRequest("New Applicant", "1 Test Way", "Fence");

        var response = await client.PostAsJsonAsync("/permits", request);

        Assert.Equal(HttpStatusCode.Created, response.StatusCode);
        var created = await response.Content.ReadFromJsonAsync<Permit>();
        Assert.NotNull(created);
        Assert.Equal("New Applicant", created!.ApplicantName);
        Assert.Equal("Intake", created.Status);
    }

    [Fact]
    public async Task Post_Permit_WithMissingFields_Returns400()
    {
        var client = _factory.CreateClient();
        var request = new CreatePermitRequest("", "", "");

        var response = await client.PostAsJsonAsync("/permits", request);

        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
    }
}
