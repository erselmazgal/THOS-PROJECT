using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Thos_project.Models
{
    public class ProductProperty
    {
        public int ProductPropertyId { get; set; }
        public int ProductId { get; set; }
        public int PropertyId { get; set; }
    }
}