---
title: "Lab 03 — Implement the Endpoint & Test"
---

# Lab 03 — Implement the Endpoint & Test

⏱️ ~30 min · Module: [Pull Requests & Review](../modules/03-pull-requests-and-review.md) · [← Home](../index.md)

**Goal:** implement `POST /permits/{id}/inspections` and prove it works with an xUnit test.

> This is the **Commit** step where the actual feature lands. Work on your
> `feature/<issue-number>-schedule-inspection` branch from Lab 02.

Stuck? The full answer is in [`solutions/`](../../solutions/README.md) — but try it first.

## Step 1 — Add the model

Open `src/CivicPermit.Api/Models/Permit.cs`. Add an `Inspections` list to `Permit`, then
add the `Inspection` type and its request record. The file should look like this:

```csharp
namespace CivicPermit.Api.Models;

public class Permit
{
    public int Id { get; set; }
    public string ApplicantName { get; set; } = string.Empty;
    public string Address { get; set; } = string.Empty;
    public string PermitType { get; set; } = string.Empty;
    public string Status { get; set; } = "Intake";

    // NEW: inspections scheduled for this permit.
    public List<Inspection> Inspections { get; set; } = new();
}

public record CreatePermitRequest(string ApplicantName, string Address, string PermitType);

// NEW: an inspection scheduled against a permit.
public class Inspection
{
    public int Id { get; set; }
    public int PermitId { get; set; }
    public string InspectionType { get; set; } = string.Empty; // e.g., "Framing", "Final"
    public DateOnly ScheduledFor { get; set; }
    public string Status { get; set; } = "Scheduled";
}

// NEW: request body for POST /permits/{id}/inspections.
public record ScheduleInspectionRequest(string InspectionType, DateOnly ScheduledFor);
```

## Step 2 — Add the store method

Open `src/CivicPermit.Api/Store/PermitStore.cs`. Add an inspection counter field and an
`AddInspection` method:

```csharp
// Add next to _nextPermitId:
private int _nextInspectionId;

// Add as a new method on PermitStore:
public Inspection? AddInspection(int permitId, string inspectionType, DateOnly scheduledFor)
{
    if (!_permits.TryGetValue(permitId, out var permit))
    {
        return null;
    }

    var inspection = new Inspection
    {
        Id = Interlocked.Increment(ref _nextInspectionId),
        PermitId = permitId,
        InspectionType = inspectionType,
        ScheduledFor = scheduledFor
    };

    permit.Inspections.Add(inspection);
    return inspection;
}
```

## Step 3 — Add the endpoint

Open `src/CivicPermit.Api/Program.cs`. Replace the `// Feature (#…)` comment (from Lab 02)
with the real endpoint, just above `app.Run();`:

```csharp
// Schedule an inspection for an existing permit.
app.MapPost("/permits/{id:int}/inspections", (int id, ScheduleInspectionRequest request, PermitStore store) =>
{
    if (store.GetById(id) is null)
    {
        return Results.NotFound();
    }

    if (string.IsNullOrWhiteSpace(request.InspectionType) || request.ScheduledFor == default)
    {
        return Results.BadRequest("InspectionType and ScheduledFor are required.");
    }

    var inspection = store.AddInspection(id, request.InspectionType, request.ScheduledFor);
    return Results.Created($"/permits/{id}/inspections/{inspection!.Id}", inspection);
});
```

Build to catch typos:

```bash
dotnet build
```

## Step 4 — Add the test

Create `tests/CivicPermit.Api.Tests/InspectionsEndpointsTests.cs`:

```csharp
using System.Net;
using System.Net.Http.Json;
using CivicPermit.Api.Models;
using Microsoft.AspNetCore.Mvc.Testing;

namespace CivicPermit.Api.Tests;

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
```

## Step 5 — Run the tests

```bash
dotnet test
```

You should now see **8 passing tests** (the original 5 plus your 3).

## Step 6 — Try it live (optional)

```bash
dotnet run --project src/CivicPermit.Api
# In another terminal:
curl -X POST http://localhost:5150/permits/1/inspections \
  -H "Content-Type: application/json" \
  -d '{"inspectionType":"Framing","scheduledFor":"2026-08-15"}'
```

You'll get a `201 Created` with the new inspection JSON.

## Step 7 — Commit your work

```bash
git add src/ tests/
git commit -m "feat: add schedule-inspection endpoint and tests

Adds POST /permits/{id}/inspections with 201/400/404 behavior and
xUnit coverage.

Refs #<issue-number>"
git push
```

## ✅ Checkpoint

- [ ] `dotnet test` prints **Passed: 8**.
- [ ] Your changes are committed and pushed to your feature branch.

> 💡 **Copilot Connection:** Writing xUnit tests is a sweet spot for Copilot — it can
> suggest cases like the 404 and 400 paths. The Copilot workshop dives in; today you write
> them so you know what good coverage looks like.

## ➡️ Next

[**Lab 04 — Open a pull request**](lab-04-open-pull-request.md)
