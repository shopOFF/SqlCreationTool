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
        private readonly string filePath;
        private IList<dynamic> excelList;

        public ToolController(ITableCreationService sQLCreationService, IPackageCreationService packageCreationService, 
            IValidationCreationService validationCreationService, IReadExcelService readExcelService)
        {
            this.tableCreationService = sQLCreationService;
            this.packageCreationService = packageCreationService;
            this.validationCreationService = validationCreationService;
            this.readExcelService = readExcelService;
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

            this.tableCreationService.CreateTableSQL(this.filePath, excelList, companyModel);

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

            this.packageCreationService.CreatePackagesSQL(this.filePath, companyModel);
            this.packageCreationService.CreatePackageBodiesSQL(this.filePath, companyModel);

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

            this.validationCreationService.CreateValidationSQL(this.filePath, excelList, companyModel);

            return View();
        }
    }
}
