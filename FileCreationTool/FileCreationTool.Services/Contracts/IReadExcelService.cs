using System;
using System.Collections.Generic;
using System.Text;

namespace FileCreationTool.Services.Contracts
{
    public interface IReadExcelService
    {
        List<dynamic> ReadExcel(string filePath, string excelSheetName);
    }
}
