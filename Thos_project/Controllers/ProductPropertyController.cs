using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Thos_project.DAL;
using Thos_project.Models;

namespace Thos_project.Controllers
{
    [AdminFilter]
    public class ProductPropertyController : Controller
    {
        private ThosCafeTaskDB _context = new ThosCafeTaskDB();

        // Ürün özelliklerini listele
        public ActionResult Index()
        {
            var productProperties = _context.ProductProperty.ToList();
            return View(productProperties);
        }

        // Yeni ürün özelliği ekle
        public ActionResult Create()
        {
            ViewBag.Products = new SelectList(_context.Product, "ProductId", "ProductName");
            ViewBag.Properties = new SelectList(_context.Property, "PropertyId", "Key");
            return View();
        }

        [HttpPost]
        public ActionResult Create(ProductProperty productProperty)
        {
            if (ModelState.IsValid)
            {
                _context.ProductProperty.Add(productProperty);
                _context.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.Products = new SelectList(_context.Product, "ProductId", "ProductName", productProperty.ProductId);
            ViewBag.Properties = new SelectList(_context.Property, "PropertyId", "Key", productProperty.PropertyId);
            return View(productProperty);
        }

        // Ürün özelliği düzenle
        public ActionResult Edit(int id)
        {
            var productProperty = _context.ProductProperty.Find(id);
            ViewBag.Products = new SelectList(_context.Product, "ProductId", "ProductName", productProperty.ProductId);
            ViewBag.Properties = new SelectList(_context.Property, "PropertyId", "Key", productProperty.PropertyId);
            return View(productProperty);
        }

        [HttpPost]
        public ActionResult Edit(ProductProperty productProperty,int id)
        {
            if (ModelState.IsValid)
            {
                var existingCategory = _context.ProductProperty.Find(id); // ID'yi kullanarak mevcut kategoriyi bul

                // Var olan kaydın değerlerini güncelle
                // Sadece diğer özellikleri güncelle
                existingCategory.ProductId = productProperty.ProductId;
                existingCategory.PropertyId = productProperty.PropertyId;
                _context.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.Products = new SelectList(_context.Product, "ProductId", "ProductName", productProperty.ProductId);
            ViewBag.Properties = new SelectList(_context.Property, "PropertyId", "Key", productProperty.PropertyId);
            return View(productProperty);
        }


      


        // Ürün özelliği sil
        public ActionResult Delete(int id)
        {
            var productProperty = _context.ProductProperty.Find(id);
            return View(productProperty);
        }

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
            var productProperty = _context.ProductProperty.Find(id);
            _context.ProductProperty.Remove(productProperty);
            _context.SaveChanges();
            return RedirectToAction("Index");
        }
    }
}