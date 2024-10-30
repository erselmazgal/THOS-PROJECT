using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web.Mvc;
using Moq;
using NUnit.Framework;
using Thos_project.Controllers;
using Thos_project.DAL;
using Thos_project.Models;
using Thos_project.Services;

namespace Thos_project.Tests
{
    [TestFixture]
    public class ProductCustomerControllerTests
    {
        private Mock<ThosCafeTaskDB> _mockContext;
        private Mock<ExchangeRateService> _mockExchangeRateService;
        private ProductCustomerController _controller;

        [SetUp]
        public void Setup()
        {
            _mockContext = new Mock<ThosCafeTaskDB>();

            // Test verilerini hazırlayın
            var categories = new List<Category>
            {
                new Category { CategoryId = 1, CategoryName = "Beverages" },
                new Category { CategoryId = 2, CategoryName = "Snacks" }
            }.AsQueryable();

            var products = new List<Product>
            {
                new Product { ProductId = 1, ProductName = "Coke", Price = 10.0m, CategoryId = 1, IsDeleted = false },
                new Product { ProductId = 2, ProductName = "Chips", Price = 5.0m, CategoryId = 2, IsDeleted = false }
            }.AsQueryable();

            var mockCategorySet = new Mock<DbSet<Category>>();
            mockCategorySet.As<IQueryable<Category>>().Setup(m => m.Provider).Returns(categories.Provider);
            mockCategorySet.As<IQueryable<Category>>().Setup(m => m.Expression).Returns(categories.Expression);
            mockCategorySet.As<IQueryable<Category>>().Setup(m => m.ElementType).Returns(categories.ElementType);
            mockCategorySet.As<IQueryable<Category>>().Setup(m => m.GetEnumerator()).Returns(categories.GetEnumerator());

            var mockProductSet = new Mock<DbSet<Product>>();
            mockProductSet.As<IQueryable<Product>>().Setup(m => m.Provider).Returns(products.Provider);
            mockProductSet.As<IQueryable<Product>>().Setup(m => m.Expression).Returns(products.Expression);
            mockProductSet.As<IQueryable<Product>>().Setup(m => m.ElementType).Returns(products.ElementType);
            mockProductSet.As<IQueryable<Product>>().Setup(m => m.GetEnumerator()).Returns(products.GetEnumerator());

            _mockContext.Setup(m => m.Category).Returns(mockCategorySet.Object);
            _mockContext.Setup(m => m.Product).Returns(mockProductSet.Object);

            _mockExchangeRateService = new Mock<ExchangeRateService>();
            _mockExchangeRateService.Setup(m => m.GetExchangeRates()).Returns((1, 1)); // USD ve EUR döviz kurlarını döndür

            //_controller = new ProductCustomerController(_mockContext.Object, _mockExchangeRateService.Object); //test için aktif et
        }

        [Test]
        public void Index_Returns_View_With_Products()
        {
            // Act
            var result = _controller.Index() as ViewResult;

            // Assert
            Assert.That(result, Is.Not.Null);
            var model = result.Model as List<ProductWithCategoryViewModel>;
            Assert.That(model, Is.Not.Null);
            Assert.That(model.Count, Is.EqualTo(2)); // İki ürün bekliyoruz
        }
    }
}
