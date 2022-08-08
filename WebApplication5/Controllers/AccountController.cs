using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Security.Claims;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using WebApplication5.Models.DB;

namespace RailwayProject.Controllers
{
    public class AccountController : Controller
    {
        [AllowAnonymous]
        public IActionResult SignIn()
        {
            return View();
        }
        [AllowAnonymous]
        public IActionResult SignUp()
        {
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> SignIn(string phone, string password)
        {
            if (phone == "09218251687" && password == "admin")
            {
                List<Claim> claims = new List<Claim>() {
                new Claim("Role","Admin")
            };
                ClaimsIdentity id = new ClaimsIdentity(claims, "Authn");
                ClaimsPrincipal cp = new ClaimsPrincipal(id);
                await HttpContext.SignInAsync("Authn", cp);
                return RedirectToAction("AdminDashboard");
            }
            else
            {
                RailwayDBContext db = new RailwayDBContext();
                if (db.PASSENGER.Any(p => p.PHONE == phone && p.PASSW == password) == true)
                {
                    PASSENGER p = db.PASSENGER.FirstOrDefault(p => p.PHONE == phone);
                    List<Claim> uclaims = new List<Claim>() {
                        new Claim("Role","User"),
                        new Claim(ClaimTypes.Name,p.FNAME + " " + p.LNAME),
                        new Claim(ClaimTypes.Sid,p.PASSENGER_ID.ToString())
                        };
                    ClaimsIdentity userid = new ClaimsIdentity(uclaims, "Authn");
                    ClaimsPrincipal usercp = new ClaimsPrincipal(userid);
                    await HttpContext.SignInAsync("Authn", usercp);
                    return RedirectToAction("userDashboard");
                }
                else
                    return RedirectToAction("SignIn");
            }
        }
        [HttpPost]
        public IActionResult SignUp(string fname, string lname, string father_name, string sx, string passw, string birth, string phone)
        {
            RailwayDBContext db = new RailwayDBContext();
            if (db.PASSENGER.Any(x => x.PHONE == phone) == false)
            {
                DateTime dbirth = Convert.ToDateTime(birth);
                PASSENGER p = new PASSENGER()
                {
                    FNAME = fname,
                    LNAME = lname,
                    FATHER_NAME = father_name,
                    SX = sx,
                    PASSW = passw,
                    BIRTH = dbirth,
                    PHONE = phone,
                    REG_DATE = DateTime.Now,
                    ADDRESS = "اختیاری"
                };
                db.PASSENGER.Add(p);
                db.SaveChanges();
                return RedirectToAction("SignIn");
            }
            else
                return RedirectToAction("SignUp");
        }
        [Authorize(Policy ="adminSignInPolicy")]
        public IActionResult AdminDashboard()
        {
            
            return View();
        }
       [Authorize(Policy = "adminSignInPolicy")]
        public IActionResult SignOut()
        {
            HttpContext.SignOutAsync("adminAuthn");
            return RedirectToAction("SignIn");
        }
        [Authorize(Policy = "userSignInPolicy")]
        public IActionResult userDashboard()
        {
            var id = this.User.FindFirstValue(ClaimTypes.Sid);
            int int_id = Convert.ToInt32(id);
            RailwayDBContext db = new RailwayDBContext();            
            return View(db.PASSENGER.Find(int_id));
        }
        [HttpPost]
        [Authorize(Policy ="userSignInPolicy")]
        public IActionResult edit(string fname, string lname, string father_name, string sx, string passw, string birth, string phone, string address)
        {
            var id = this.User.FindFirstValue(ClaimTypes.Sid);
            int int_id = Convert.ToInt32(id);
            RailwayDBContext db = new RailwayDBContext();
            PASSENGER p = new PASSENGER();
            p = db.PASSENGER.Find(int_id);
            DateTime dbirth = Convert.ToDateTime(birth);
            
            p = db.PASSENGER.Find(int_id);
            if (p.FNAME != fname)
                db.PASSENGER.Find(int_id).FNAME = fname;
            if (p.LNAME != lname)
                db.PASSENGER.Find(int_id).LNAME = lname;
            if (p.FATHER_NAME != father_name)
                db.PASSENGER.Find(int_id).FATHER_NAME = father_name;
            if (p.PASSW != passw)
                db.PASSENGER.Find(int_id).PASSW = passw;
            if (p.BIRTH != dbirth)
                db.PASSENGER.Find(int_id).BIRTH = dbirth;
            if (p.ADDRESS != address)
                db.PASSENGER.Find(int_id).ADDRESS = address;
            db.SaveChanges();            
            return RedirectToAction("userDashboard", db.PASSENGER.Find(int_id));
        }

        [Authorize(Policy = "userSignInPolicy")]
        public IActionResult SignOff()
        {
            HttpContext.SignOutAsync("userAuthn");
            return RedirectToAction("SignIn");
        }
    }
}