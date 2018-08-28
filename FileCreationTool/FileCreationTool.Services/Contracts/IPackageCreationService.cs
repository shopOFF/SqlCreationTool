using FileCreationTool.Models;

namespace FileCreationTool.Services.Contracts
{
    public interface IPackageCreationService
    {
        string CreatePackageBodiesSQL(string filePath, CompanyModel viewModel);
        string CreatePackagesSQL(string filePath, CompanyModel viewModel);
    }
}