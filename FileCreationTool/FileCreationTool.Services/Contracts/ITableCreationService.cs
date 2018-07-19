using FileCreationTool.Models;
using System.Collections.Generic;

namespace FileCreationTool.Services.Contracts
{
    public interface ITableCreationService
    {
        void CreateTableSQL(string filePath, IList<dynamic> data, CompanyModel companyModel);
    }
}