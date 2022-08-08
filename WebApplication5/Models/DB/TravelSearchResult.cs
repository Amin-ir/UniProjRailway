﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication5.Models.DB
{
    public partial class TravelSearchResult
    {
        public int TRAVEL_ID { get; set; }
        public DateTime START_TIME { get; set; }
        public DateTime ARRIVAL_TIME { get; set; }
        public int TRAIN_ID { get; set; }
        public int START_ID { get; set; }
        public int DEST_ID { get; set; }
        public int BASE_PRICE { get; set; }
        public string startPoint { get; set; }
        public string destPoint { get; set; }
        [Column("Full Capacity")]
        public int? FullCapacity { get; set; }
        [Column("Remaining Capacity")]
        public int? RemainingCapacity { get; set; }
    }
}
