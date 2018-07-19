using FileCreationTool.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace FileCreationTool.Services.Contracts
{
    public interface IValidationCreationService
    {
        void CreateValidationSQL(string filePath, IList<dynamic> data, CompanyModel companyModel);
    }
}
