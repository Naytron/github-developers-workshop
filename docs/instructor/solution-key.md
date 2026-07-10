---
title: "Instructor — Solution Key"
---

# Instructor — Solution Key

[← Home](../index.md)

The complete answers for the hands-on feature, plus quick recovery recipes. The same
files live, ready to copy, in [`solutions/`](../../solutions/README.md).

> Keep this open in a private window during delivery to unblock attendees fast.

## The feature — full reference

### `src/CivicPermit.Api/Models/Permit.cs`

```csharp
namespace CivicPermit.Api.Models;

public class Permit
{
    public int Id { get; set; }
    public string ApplicantName { get; set; } = string.Empty;
    public string Address { get; set; } = string.Empty;
    public string PermitType { get; set; } = string.Empty;
    public string Status { get; set; } = "Intake";
    public List<Inspection> Inspections { get; set; } = new();
}

public record CreatePermitRequest(string ApplicantName, string Address, string PermitType);

public class Inspection
{
    public int Id { get; set; }
    public int PermitId { get; set; }
    public string InspectionType { get; set; } = string.Empty;
    public DateOnly ScheduledFor { get; set; }
    public string Status { get; set; } = "Scheduled";
}

public record ScheduleInspectionRequest(string InspectionType, DateOnly ScheduledFor);
```

### `src/CivicPermit.Api/Store/PermitStore.cs` (added members)

```csharp
private int _nextInspectionId;

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

### `src/CivicPermit.Api/Program.cs` (added endpoint, above `app.Run();`)

```csharp
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

### `tests/CivicPermit.Api.Tests/InspectionsEndpointsTests.cs`

See the full file in
[`solutions/tests/CivicPermit.Api.Tests/InspectionsEndpointsTests.cs`](../../solutions/tests/CivicPermit.Api.Tests/InspectionsEndpointsTests.cs).
Three cases: `201` created, `404` unknown permit, `400` missing fields.

### Expected result

```bash
dotnet test
# Passed!  - Failed: 0, Passed: 8, Skipped: 0, Total: 8
```

## Fastest way to unblock an attendee

```bash
# From the repo root, drop in the reference files and re-test:
cp solutions/src/CivicPermit.Api/Models/Permit.cs   src/CivicPermit.Api/Models/Permit.cs
cp solutions/src/CivicPermit.Api/Store/PermitStore.cs src/CivicPermit.Api/Store/PermitStore.cs
cp solutions/src/CivicPermit.Api/Program.cs          src/CivicPermit.Api/Program.cs
cp solutions/tests/CivicPermit.Api.Tests/InspectionsEndpointsTests.cs tests/CivicPermit.Api.Tests/InspectionsEndpointsTests.cs
dotnet test
```

## Recovery recipes

### "I committed on `main`"

```bash
git switch -c feature/<issue-number>-schedule-inspection   # keep the commit on a branch
git switch main
git reset --hard origin/main                          # restore main
git switch feature/<issue-number>-schedule-inspection       # continue here
```

### "My push was rejected (protected branch)"

Expected once Lab 07 protection is on — open a PR instead of pushing to `main`.

### "CI won't run on my fork"

Enable Actions: repo **Settings → Actions → General → Allow all actions → Save**
(Lab 06 Step 0).

### "I can't approve my own PR"

Expected. Pair-approve, have the instructor approve, or set required approvals to `0` for
the exercise.

### "Release notes are empty"

The feature must be merged as a **PR into `main`** before you tag. Merge first, then
`gh release create`.

### Reset the sample app to starter (between cohorts)

The starter has **no** inspections endpoint. Restore tracked files and confirm:

```bash
git switch main && git pull
git restore src/ tests/    # if a demo left local edits
dotnet test                # expect Passed: 5 on a clean starter
```
