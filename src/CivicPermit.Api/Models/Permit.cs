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