using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Thos_project.Models
{
    public class Property
    {
        [Key] // Anahtar olarak kullanılacağını belirtir
        public int PropertyId { get; set; }
        public string Key { get; set; }
        public string Value { get; set; }
    }
}