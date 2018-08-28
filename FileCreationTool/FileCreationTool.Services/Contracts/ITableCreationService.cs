using FileCreationTool.Models;
using System.Collections.Generic;
using System.Text;

namespace FileCreationTool.Services.Contracts
{
    public interface ITableCreationService
    {
        string CreateTableSQL(string filePath, IList<dynamic> data, CompanyModel companyModel);
    }
}