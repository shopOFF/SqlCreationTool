using FileCreationTool.Services;
using FileCreationTool.Services.Contracts;
using Moq;
using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Text;

namespace FileCreationTool.UnitTests.ServicesTests.SQLFileCreationServiceTests
{
    [TestFixture]
    public class CreateSQLFile_Should
    {
        [TestCase]
        public void CreateSQLFile_WhenValuesAreNotProvidedOrValid_ShouldThrowArgumentException()
        {
            // Arrange
            var sqlFileCreationService= new SQLFileCreationService();

            // Act & Assert
            Assert.Throws<ArgumentException>(() => sqlFileCreationService.CreateSQLFile(It.IsAny<string>(), string.Empty, It.IsAny<string>(), It.IsAny<string>()));
        }
    }
}
