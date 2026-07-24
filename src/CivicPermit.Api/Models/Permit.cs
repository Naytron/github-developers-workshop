namespace CivicPermit.Api.Models;

public class Permit
{
    public int Id { get; set; }
    public string ApplicantName { get; set; } = string.Empty;
    public string Address { get; set; } = string.Empty;
    public string PermitType { get; set; } = string.Empty;
    public string Status { get; set; } = "Intake";
}

public record CreatePermitRequest(string ApplicantName, string Address, string PermitType);