﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace WebApplication5.Models.DB
{
    public partial class CITY
    {
        public CITY()
        {
            TRAVELDEST = new HashSet<TRAVEL>();
            TRAVELSTART = new HashSet<TRAVEL>();
        }

        [Key]
        public int CITY_ID { get; set; }
        [Required]
        public string CITY_NAME { get; set; }

        [InverseProperty(nameof(TRAVEL.DEST))]
        public virtual ICollection<TRAVEL> TRAVELDEST { get; set; }
        [InverseProperty(nameof(TRAVEL.START))]
        public virtual ICollection<TRAVEL> TRAVELSTART { get; set; }
    }
}