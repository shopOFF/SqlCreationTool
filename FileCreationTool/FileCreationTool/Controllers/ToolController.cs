using FileCreationTool.Models;
using FileCreationTool.Services.Contracts;
using FileCreationTool.ViewModels;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace FileCreationTool.Controllers
{
    public class ToolController : Controller
    {
        private readonly ITableCreationService tableCreationService;
        private readonly IPackageCreationService packageCreationService;
        private readonly IValidationCreationService validationCreationService;
        private readonly IReadExcelService readExcelService;
        private readonly ISQLFileCreationService sQLFileCreationService;
        private readonly string filePath;
        private IList<dynamic> excelList;

        public ToolController(ITableCreationService sQLCreationService, IPackageCreationService packageCreationService,
            IValidationCreationService validationCreationService, IReadExcelService readExcelService, ISQLFileCreationService sQLFileCreationService)
        {
            this.tableCreationService = sQLCreationService;
            this.packageCreationService = packageCreationService;
            this.validationCreationService = validationCreationService;
            this.readExcelService = readExcelService;
            this.sQLFileCreationService = sQLFileCreationService;
            this.filePath = Directory.GetCurrentDirectory();
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

            excelList = this.readExcelService.ReadExcel($@"{this.filePath}\Forms.xlsx", $"{tableFirstToUpper}");

            var tableSQL = this.tableCreationService.CreateTableSQL(this.filePath, excelList, companyModel);
            this.sQLFileCreationService.CreateSQLFile($@"{filePath}\GeneratedTables", tableSQL, companyModel.CompanyName, companyModel.TableName);

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

            var packageSQL = this.packageCreationService.CreatePackagesSQL(this.filePath, companyModel);
            var packageBodiesSQL = this.packageCreationService.CreatePackageBodiesSQL(this.filePath, companyModel);
            this.sQLFileCreationService.CreateSQLFile($@"{filePath}\GeneratedPackages\Packages", packageSQL, companyModel.CompanyName, companyModel.TableName);
            this.sQLFileCreationService.CreateSQLFile($@"{filePath}\GeneratedPackages\PackageBodies", packageBodiesSQL, companyModel.CompanyName, companyModel.TableName);

            return View();
        }

        [HttpGet]
        public IActionResult CreateValidation()
        {
            return View();
        }

        [HttpPost]
        public IActionResult CreateValidation(CompanyViewModel viewModel)
        {
            var companyModel = new CompanyModel() { CompanyName = viewModel.CompanyName, TableName = viewModel.TableName };
            var tableFirstToUpper = companyModel.TableName.First().ToString().ToUpper() + companyModel.TableName.Substring(1);

            excelList = this.readExcelService.ReadExcel($@"{this.filePath}\Forms.xlsx", $"{tableFirstToUpper}");

            var validationSQL= this.validationCreationService.CreateValidationSQL(this.filePath, excelList, companyModel);
            this.sQLFileCreationService.CreateSQLFile($@"{filePath}\GeneratedValidation", validationSQL, companyModel.CompanyName, $"{companyModel.TableName}-validation");

            return View();
        }
    }
}
