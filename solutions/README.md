# Reference solution — "Schedule an inspection"

These are **complete, working versions** of the files you change during the workshop to
implement the recurring feature:

> **"Add the ability to schedule an inspection for an existing permit."**

They are **not** part of the build (they live outside `src/` and `tests/`), so the
starter project stays clean. Use them as an answer key — for example if a learner gets
stuck in Lab 2.2, or when an instructor demos the finished result.

## What changed vs. the starter

| File | Change |
| ---- | ------ |
| `src/CivicPermit.Api/Models/Permit.cs` | Adds the `Inspection` model, `ScheduleInspectionRequest`, and an `Inspections` list on `Permit`. |
| `src/CivicPermit.Api/Store/PermitStore.cs` | Adds `AddInspection(...)`. |
| `src/CivicPermit.Api/Program.cs` | Adds `POST /permits/{id}/inspections`. |
| `tests/CivicPermit.Api.Tests/InspectionsEndpointsTests.cs` | New xUnit tests for the endpoint. |

## Apply it

From the repository root, copy the reference files over the starter files:

```bash
# Copy the reference implementation over the starter files:
# Bash
cp solutions/src/CivicPermit.Api/Models/Permit.cs   src/CivicPermit.Api/Models/Permit.cs
cp solutions/src/CivicPermit.Api/Store/PermitStore.cs src/CivicPermit.Api/Store/PermitStore.cs
cp solutions/src/CivicPermit.Api/Program.cs          src/CivicPermit.Api/Program.cs
cp solutions/tests/CivicPermit.Api.Tests/InspectionsEndpointsTests.cs tests/CivicPermit.Api.Tests/InspectionsEndpointsTests.cs
# PowerShell
Copy-Item solutions/src/CivicPermit.Api/Models/Permit.cs -Destination src/CivicPermit.Api/Models/Permit.cs -Force
Copy-Item solutions/src/CivicPermit.Api/Store/PermitStore.cs -Destination src/CivicPermit.Api/Store/PermitStore.cs -Force
Copy-Item solutions/src/CivicPermit.Api/Program.cs -Destination src/CivicPermit.Api/Program.cs -Force
Copy-Item solutions/tests/CivicPermit.Api.Tests/InspectionsEndpointsTests.cs -Destination tests/CivicPermit.Api.Tests/InspectionsEndpointsTests.cs -Force

# Then verify (either shell):
dotnet test
```

You should see the five original tests plus three new inspection tests, all green.

> 💡 If the first `dotnet test` fails with
> `CS0246: type or namespace ... could not be found`
> immediately after bulk-copying these files, it's a stale incremental build, not a
> real error. Run `dotnet clean` once, then `dotnet test` again.
