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
    public class Constructor_Should
    {
        //[TestCase]
        //public void Constructo_WhenValuesAreValid_ShouldCallCreateSQLFileSuccessfully()
        //{
        //    // Arrange
        //    var sqlFileCreationServiceMock = new Mock<ISQLFileCreationService>();
        //    sqlFileCreationServiceMock.Setup(x => x.CreateSQLFile(It.IsAny<string>(), It.IsAny<StringBuilder>(), It.IsAny<string>(), It.IsAny<string>()));

        //    var tableCreationService = new TableCreationService();
        //    var collection= new List<dynamic>() { "test" };
        //    var companyModel = new CompanyModel() { CompanyName = "Test Company", TableName = "Test Table" };

        //    // Act 
        //    tableCreationService.CreateTableSQL(It.IsAny<string>(), collection, companyModel);
        //    tableCreationService.CreateTableSQL(It.IsAny<string>(), collection, companyModel);

        //    // Assert
        //    sqlFileCreationServiceMock.Verify(x => x.CreateSQLFile(It.IsAny<string>(), It.IsAny<StringBuilder>(), It.IsAny<string>(), It.IsAny<string>()), Times.Exactly(2));
        //}

        [TestCase]
        public void Constructor_WhenValuesAreNotProvidedOrValid_ShouldThrowArgumentException()
        {
            // Arrange
            var sqlFileCreationServiceMock = new Mock<ISQLFileCreationService>();
            sqlFileCreationServiceMock.Setup(x => x.CreateSQLFile(It.IsAny<string>(), It.IsAny<string>(), It.IsAny<string>(), It.IsAny<string>()));

            var tableCreationService = new TableCreationService();
            var collection = new List<dynamic>() { "test" };
            var companyModel = new CompanyModel();

            // Act & Assert
            Assert.Throws<ArgumentException>(() => tableCreationService.CreateTableSQL(It.IsAny<string>(), collection, companyModel));
        }
    }
}
