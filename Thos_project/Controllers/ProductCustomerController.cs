using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Thos_project.DAL;
using Thos_project.Models;

namespace Thos_project.Controllers
{
    public class ProductCustomerController : Controller
    {
        private ThosCafeTaskDB _context = new ThosCafeTaskDB();

        // GET: ProductCustomer
        public ActionResult Index()
        {
            var productsWithCategories = _context.Product
                .Where(p => !p.IsDeleted)
                .Join(_context.Category,
                    product => product.CategoryId,
                    category => category.CategoryId,
                    (product, category) => new ProductWithCategoryViewModel
                    {
                        ProductName = product.ProductName,
                        Price = product.Price,
                        CategoryName = category.CategoryName,
                        ImagePath = product.ImagePath // ImagePath'i ekliyoruz
                    })
                .ToList();

            return View(productsWithCategories);
        }

    }
}