using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace Thos_project.Models
{
    public class AdminFilter : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (filterContext.HttpContext.Session["IsAdmin"] == null || !(bool)filterContext.HttpContext.Session["IsAdmin"])
            {
                filterContext.Result = new RedirectToRouteResult(new RouteValueDictionary
            {
                { "controller", "User" },
                { "action", "Login" }
            });
            }
            base.OnActionExecuting(filterContext);
        }
    }
}