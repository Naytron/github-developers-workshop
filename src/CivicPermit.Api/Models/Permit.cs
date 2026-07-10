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
}

/// <summary>Request body for creating a new permit (POST /permits).</summary>
public record CreatePermitRequest(string ApplicantName, string Address, string PermitType);
