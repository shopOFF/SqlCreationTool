using FileCreationTool.Models;
using FileCreationTool.Services.Contracts;
using FileCreationTool.ViewModels;
using Microsoft.AspNetCore.Mvc;
using System.Linq;

namespace FileCreationTool.Controllers
{
    public class ToolController : Controller
    {
        private readonly ITableCreationService tableCreationService;
        private readonly IPackageCreationService packageCreationService;

        public ToolController(ITableCreationService sQLCreationService, IPackageCreationService packageCreationService)
        {
            this.tableCreationService = sQLCreationService;
            this.packageCreationService = packageCreationService;
        }

        [HttpGet]
        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Index(CompanyViewModel viewModel)
        {
            var companyModel = new CompanyModel() { CompanyName = viewModel.CompanyName, TableName = viewModel.TableName };
            var tableFirstToUpper = companyModel.TableName.First().ToString().ToUpper() + companyModel.TableName.Substring(1);

            var excelList = this.tableCreationService.ReadExcel(@"C:\Users\ishopov\Desktop\FileCreationTool\FileCreationTool\Forms.xlsx", $"{tableFirstToUpper}");

            this.tableCreationService.CreateSQL(excelList, companyModel);

            return View();
        }

        [HttpGet]
        public IActionResult CreatePackages()
        {
            return View();
        }

        [HttpPost]
        public IActionResult CreatePackages(CompanyViewModel viewModel)
        {
            var companyModel = new CompanyModel() { CompanyName = viewModel.CompanyName, TableName = viewModel.TableName };      

            this.packageCreationService.CreatePackages(companyModel);
            this.packageCreationService.CreatePackageBodies(companyModel);

            return View();
        }
    }
}
