using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace FileCreationTool.Services.Contracts
{
    public interface IReadExcelService
    {
      Task<List<dynamic>> ReadExcel(string filePath, string excelSheetName);
    }
}
