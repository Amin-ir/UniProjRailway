﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication5.Models.DB
{
    public partial class UsersSearchResult
    {
        public string img { get; set; }
        public DateTime REG_DATE { get; set; }
        public int PASSENGER_ID { get; set; }
        public string PASSW { get; set; }
        public string SX { get; set; }
        public string FNAME { get; set; }
        public string LNAME { get; set; }
        public DateTime BIRTH { get; set; }
        public string FATHER_NAME { get; set; }
        public string PHONE { get; set; }
        public string ADDRESS { get; set; }
    }
}