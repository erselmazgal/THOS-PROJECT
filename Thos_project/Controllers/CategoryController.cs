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
    public class CategoryController : Controller
    {
        private ThosCafeTaskDB _context = new ThosCafeTaskDB();

        // Kategorileri listele
        public ActionResult Index()
        {
            var categories = _context.Category.Where(c => !c.IsDeleted).ToList();
            return View(categories);
        }

        // Yeni kategori ekle
        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(Category category)
        {
            if (ModelState.IsValid)
            {
                category.CreatedDate = DateTime.Now;
                _context.Category.Add(category);
                _context.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(category);
        }

        // Kategori düzenle
        public ActionResult Edit(int id)
        {
            var category = _context.Category.Find(id);
            return View(category);
        }

        [HttpPost]
        public ActionResult Edit(int id, Category category)
        {
            if (ModelState.IsValid)
            {
                var existingCategory = _context.Category.Find(id); // ID'yi kullanarak mevcut kategoriyi bul
                if (existingCategory == null)
                {
                    return HttpNotFound(); // Kayıt bulunamazsa hata döndür
                }

                // Var olan kaydın değerlerini güncelle
                // Sadece diğer özellikleri güncelle
                existingCategory.CategoryName = category.CategoryName;
                // Diğer özellikleri de güncelle

                _context.SaveChanges(); // Değişiklikleri kaydet
                return RedirectToAction("Index");
            }
            return View(category); // Model geçerli değilse, formu tekrar göster
        }



        // Kategori sil
        public ActionResult Delete(int id)
        {
            var category = _context.Category.Find(id);
            return View(category);
        }

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
            var category = _context.Category.Find(id);
            category.IsDeleted = true;
            _context.SaveChanges();
            return RedirectToAction("Index");
        }
    }
}