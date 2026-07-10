namespace CivicPermit.Api.Models;

/// <summary>
/// A residential permit application tracked by CivicPermit.
/// Status flows: Intake -> UnderReview -> Approved | Denied.
/// </summary>
public class Permit
{
    public int Id { get; set; }
    public string ApplicantName { get; set; } = string.Empty;
    public string Address { get; set; } = string.Empty;
    public string PermitType { get; set; } = string.Empty;
    public string Status { get; set; } = "Intake";

    /// <summary>Inspections scheduled for this permit.</summary>
    public List<Inspection> Inspections { get; set; } = new();
}

/// <summary>Request body for creating a new permit (POST /permits).</summary>
public record CreatePermitRequest(string ApplicantName, string Address, string PermitType);

/// <summary>An inspection scheduled against a permit.</summary>
public class Inspection
{
    public int Id { get; set; }
    public int PermitId { get; set; }
    public string InspectionType { get; set; } = string.Empty; // e.g., "Framing", "Final"
    public DateOnly ScheduledFor { get; set; }
    public string Status { get; set; } = "Scheduled";
}

/// <summary>Request body for scheduling an inspection (POST /permits/{id}/inspections).</summary>
public record ScheduleInspectionRequest(string InspectionType, DateOnly ScheduledFor);
