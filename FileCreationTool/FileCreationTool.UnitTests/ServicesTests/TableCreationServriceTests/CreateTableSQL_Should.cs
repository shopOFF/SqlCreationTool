using FileCreationTool.Models;
using FileCreationTool.Services;
using FileCreationTool.Services.Contracts;
using Moq;
using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Text;

namespace FileCreationTool.UnitTests.ServicesTests.TableCreationServriceTests
{
    [TestFixture]
    public class CreateTableSQL_Should
    {
        [TestCase]
        public void CreateTableSQL_WhenValuesAreValid_ShouldReturnCorrectCompanyNameSuccessfully()
        {
            // Arrange
            var tableCreationService = new TableCreationService();
            var collection = new List<dynamic>() { "test" };
            var companyModel = new CompanyModel() { CompanyName = "Test Company", TableName = "Test Table" };

            // Act 
            var tableSQL = tableCreationService.CreateTableSQL(It.IsAny<string>(), collection, companyModel);

            // Assert
            StringAssert.Contains(companyModel.CompanyName, tableSQL.ToString());
        }

        [TestCase]
        public void CreateTableSQL_WhenValuesAreInValid_ShouldThrowArgumentExceptionWithMessage()
        {
            // Arrange
            var tableCreationService = new TableCreationService();
            var collection = new List<dynamic>() { "test" };
            var companyModel = new CompanyModel();

            // Act & Assert
            Assert.That(() => tableCreationService.CreateTableSQL(It.IsAny<string>(), collection, companyModel),
                Throws.ArgumentException.With.Message.Contains("The table cannot be crated"));
        }
    }
}
