// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace WebApplication5.Models.DB
{
    [Keyless]
    public partial class TRAVELSTATION_VIEW
    {
        public int STATION_ID { get; set; }
        [Required]
        public string STATION_NAME { get; set; }
        public int TRAVEL_ID { get; set; }
    }
}