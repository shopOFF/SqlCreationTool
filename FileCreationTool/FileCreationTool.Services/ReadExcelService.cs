using System;
using System.Collections.Generic;
using System.Text;
using FileCreationTool.Services.Contracts;
using System.IO;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using System.Linq;

namespace FileCreationTool.Services
{
    public class ReadExcelService : IReadExcelService
    {
        public List<dynamic> ReadExcel(string filePath, string excelSheetName)
        {
            XSSFWorkbook workbook;

            using (FileStream file = new FileStream(filePath, FileMode.Open, FileAccess.Read))
            {
                workbook = new XSSFWorkbook(file);
            }

            ISheet sheet = workbook.GetSheet(excelSheetName);
            var list = new List<dynamic>();

            for (int row = 0; row <= sheet.LastRowNum; row++)
            {
                if (sheet.GetRow(row) != null) //null is when the row only contains empty cells 
                {
                    list.Add(sheet.GetRow(row).ToList<dynamic>());
                }
            }

            return list;
        }
    }
}
