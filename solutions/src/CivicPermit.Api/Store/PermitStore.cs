using System.Collections.Concurrent;
using CivicPermit.Api.Models;

namespace CivicPermit.Api.Store;

/// <summary>
/// A tiny, thread-safe in-memory store so CivicPermit runs with zero external
/// infrastructure. Data resets every time the app restarts.
/// </summary>
public class PermitStore
{
    private readonly ConcurrentDictionary<int, Permit> _permits = new();
    private int _nextPermitId;
    private int _nextInspectionId;

    public PermitStore()
    {
        // Seed a couple of sample permits so GET endpoints return something useful.
        Add(new Permit
        {
            ApplicantName = "Riverside Neighborhood Association",
            Address = "100 Main Street",
            PermitType = "Residential Addition",
            Status = "UnderReview"
        });
        Add(new Permit
        {
            ApplicantName = "A. Carpenter",
            Address = "42 Oak Avenue",
            PermitType = "Deck",
            Status = "Intake"
        });
    }

    public IEnumerable<Permit> GetAll() => _permits.Values.OrderBy(p => p.Id);

    public Permit? GetById(int id) => _permits.TryGetValue(id, out var permit) ? permit : null;

    public Permit Add(Permit permit)
    {
        var id = Interlocked.Increment(ref _nextPermitId);
        permit.Id = id;
        _permits[id] = permit;
        return permit;
    }

    /// <summary>
    /// Schedules an inspection against an existing permit. Returns the created
    /// inspection, or <c>null</c> if the permit does not exist.
    /// </summary>
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
}
