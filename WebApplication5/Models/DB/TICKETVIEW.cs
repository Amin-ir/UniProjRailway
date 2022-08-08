﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace WebApplication5.Models.DB
{
    [Keyless]
    public partial class TICKETVIEW
    {
        public int PASSENGER_ID { get; set; }
        [Required]
        public string SX { get; set; }
        [Required]
        public string FNAME { get; set; }
        [Required]
        public string LNAME { get; set; }
        [Column(TypeName = "date")]
        public DateTime BIRTH { get; set; }
        [Required]
        public string FATHER_NAME { get; set; }
        [Required]
        [StringLength(13)]
        public string PHONE { get; set; }
        [Required]
        public string ORG_NAME { get; set; }
        public int WAGON_NUMBER { get; set; }
        public int? COUPE_NUMBER { get; set; }
        public int SEAT_NUMBER { get; set; }
        public bool? MEAL_RESERVE { get; set; }
        public DateTime START_TIME { get; set; }
        public DateTime ARRIVAL_TIME { get; set; }
        public int BASE_PRICE { get; set; }
        [Required]
        public string startPoint { get; set; }
        [Required]
        public string destPoint { get; set; }
        public int? FINAL_PRICE { get; set; }
        public bool? IS_PAID { get; set; }
    }
}