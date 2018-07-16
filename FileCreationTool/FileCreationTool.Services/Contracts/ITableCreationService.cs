using FileCreationTool.Models;
using System.Collections.Generic;

namespace FileCreationTool.Services.Contracts
{
    public interface ITableCreationService
    {
        List<dynamic> ReadExcel(string filePath, string excelSheetName);

        void CreateSQL(IList<dynamic> data, CompanyModel companyModel);
    }
}