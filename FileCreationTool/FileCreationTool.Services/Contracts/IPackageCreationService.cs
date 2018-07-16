using FileCreationTool.Models;

namespace FileCreationTool.Services.Contracts
{
    public interface IPackageCreationService
    {
        void CreatePackageBodies(CompanyModel viewModel);
        void CreatePackages(CompanyModel viewModel);
    }
}