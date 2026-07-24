using CivicPermit.Api.Models;
using CivicPermit.Api.Store;

var builder = WebApplication.CreateBuilder(args);

// The in-memory store is registered as a singleton so all requests share the
// same data for the lifetime of the process.
builder.Services.AddSingleton<PermitStore>();

var app = builder.Build();

app.MapGet("/", () => "CivicPermit API — Residential Permit & Inspection Tracker");

// List every permit.
app.MapGet("/permits", (PermitStore store) => Results.Ok(store.GetAll()));

// Fetch a single permit by id.
app.MapGet("/permits/{id:int}", (int id, PermitStore store) =>
    store.GetById(id) is { } permit
        ? Results.Ok(permit)
        : Results.NotFound());

// Intake a new permit application.
app.MapPost("/permits", (CreatePermitRequest request, PermitStore store) =>
{
    if (string.IsNullOrWhiteSpace(request.ApplicantName)
        || string.IsNullOrWhiteSpace(request.Address)
        || string.IsNullOrWhiteSpace(request.PermitType))
    {
        return Results.BadRequest("ApplicantName, Address, and PermitType are required.");
    }

    var permit = store.Add(new Permit
    {
        ApplicantName = request.ApplicantName,
        Address = request.Address,
        PermitType = request.PermitType
    });

    return Results.Created($"/permits/{permit.Id}", permit);
});

// TODO (Lab 03): add POST /permits/{id}/inspections.

app.Run();

// Exposed so the test project can spin up the API with WebApplicationFactory<Program>.
public partial class Program { }
