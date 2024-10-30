using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using Thos_project.Models;

namespace Thos_project.DAL
{
    public class ThosCafeTaskDB : DbContext
    {
        public ThosCafeTaskDB() : base("name=ThosCafeTask")  // web.config içindeki connection string
        {
        }

        public virtual DbSet<Category> Category { get; set; }
        public virtual DbSet<Product> Product { get; set; }

        public virtual DbSet<ProductProperty> ProductProperty { get; set; }

        public virtual DbSet<Property> Property { get; set; }

        public DbSet<User> User { get; set; }

    }
}