using FileCreationTool.Models;

namespace FileCreationTool.Services.Contracts
{
    public interface IPackageCreationService
    {
        void CreatePackageBodiesSQL(string filePath, CompanyModel viewModel);
        void CreatePackagesSQL(string filePath, CompanyModel viewModel);
    }
}