﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

#nullable disable

namespace WebApplication5.Models.DB
{
    public partial class RailwayDBContext : DbContext
    {
        public RailwayDBContext()
        {
        }

        public RailwayDBContext(DbContextOptions<RailwayDBContext> options)
            : base(options)
        {
        }

        public virtual DbSet<CITY> CITY { get; set; }
        public virtual DbSet<MEAL> MEAL { get; set; }
        public virtual DbSet<MEALTRAVEL_VIEW> MEALTRAVEL_VIEW { get; set; }
        public virtual DbSet<MEAL_TRAVEL> MEAL_TRAVEL { get; set; }
        public virtual DbSet<MODEL> MODEL { get; set; }
        public virtual DbSet<ORG> ORG { get; set; }
        public virtual DbSet<PASSENGER> PASSENGER { get; set; }
        public virtual DbSet<STATION> STATION { get; set; }
        public virtual DbSet<TICKET> TICKET { get; set; }
        public virtual DbSet<TICKETVIEW> TICKETVIEW { get; set; }
        public virtual DbSet<TRAIN> TRAIN { get; set; }
        public virtual DbSet<TRAVEL> TRAVEL { get; set; }
        public virtual DbSet<TRAVELFullView> TRAVELFullView { get; set; }
        public virtual DbSet<TRAVELSTATION_VIEW> TRAVELSTATION_VIEW { get; set; }
        public virtual DbSet<TRAVEL_STATION> TRAVEL_STATION { get; set; }
        public virtual DbSet<fullTrainView> fullTrainView { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Data Source=localhost;Initial Catalog=RailwayDB;Integrated Security=True");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("Relational:Collation", "Persian_100_CI_AI_KS_WS_SC_UTF8");

            modelBuilder.Entity<CITY>(entity =>
            {
                entity.HasKey(e => e.CITY_ID)
                    .HasName("PK__CITY__6E64DFEA2DB7F6A0");

                entity.Property(e => e.CITY_ID).ValueGeneratedNever();
            });

            modelBuilder.Entity<MEAL>(entity =>
            {
                entity.HasKey(e => e.MEAL_ID)
                    .HasName("PK__MEAL__084DB7A9A98FF63B");

                entity.Property(e => e.MEAL_ID).ValueGeneratedNever();
            });

            modelBuilder.Entity<MEALTRAVEL_VIEW>(entity =>
            {
                entity.ToView("MEALTRAVEL_VIEW");
            });

            modelBuilder.Entity<MEAL_TRAVEL>(entity =>
            {
                entity.HasKey(e => new { e.TRAVEL_ID, e.MEAL_ID })
                    .HasName("MT_ID");

                entity.HasOne(d => d.MEAL)
                    .WithMany(p => p.MEAL_TRAVEL)
                    .HasForeignKey(d => d.MEAL_ID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__MEAL_TRAV__MEAL___3E52440B");

                entity.HasOne(d => d.TRAVEL)
                    .WithMany(p => p.MEAL_TRAVEL)
                    .HasForeignKey(d => d.TRAVEL_ID)
                    .HasConstraintName("FK__MEAL_TRAV__TRAVE__3F466844");
            });

            modelBuilder.Entity<MODEL>(entity =>
            {
                entity.HasKey(e => e.MODEL_ID)
                    .HasName("PK__MODEL__D959DC6B1B8011C7");

                entity.Property(e => e.MODEL_ID).ValueGeneratedNever();
            });

            modelBuilder.Entity<ORG>(entity =>
            {
                entity.HasKey(e => e.ORG_ID)
                    .HasName("PK__ORG__66696A8CA721791E");

                entity.Property(e => e.ORG_ID).ValueGeneratedNever();
            });

            modelBuilder.Entity<PASSENGER>(entity =>
            {
                entity.HasKey(e => e.PASSENGER_ID)
                    .HasName("PK__PASSENGE__8B7DBA54AF0B4176");

                entity.Property(e => e.PASSENGER_ID).ValueGeneratedNever();

                entity.Property(e => e.PHONE).IsUnicode(false);
            });

            modelBuilder.Entity<STATION>(entity =>
            {
                entity.HasKey(e => e.STATION_ID)
                    .HasName("PK__STATION__1225DC308E49E9E7");

                entity.Property(e => e.STATION_ID).ValueGeneratedNever();
            });

            modelBuilder.Entity<TICKET>(entity =>
            {
                entity.HasKey(e => new { e.TRAVEL_ID, e.PASSENGER_ID })
                    .HasName("TICKET_ID");

                entity.HasOne(d => d.PASSENGER)
                    .WithMany(p => p.TICKET)
                    .HasForeignKey(d => d.PASSENGER_ID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__TICKET__PASSENGE__3B75D760");

                entity.HasOne(d => d.TRAVEL)
                    .WithMany(p => p.TICKET)
                    .HasForeignKey(d => d.TRAVEL_ID)
                    .HasConstraintName("FK__TICKET__TRAVEL_I__3A81B327");
            });

            modelBuilder.Entity<TICKETVIEW>(entity =>
            {
                entity.ToView("TICKETVIEW");

                entity.Property(e => e.PHONE).IsUnicode(false);
            });

            modelBuilder.Entity<TRAIN>(entity =>
            {
                entity.HasKey(e => e.TRAIN_ID)
                    .HasName("PK__TRAIN__84E4D8967D860259");

                entity.Property(e => e.TRAIN_ID).ValueGeneratedNever();

                entity.HasOne(d => d.MODEL)
                    .WithMany(p => p.TRAIN)
                    .HasForeignKey(d => d.MODEL_ID)
                    .OnDelete(DeleteBehavior.SetNull)
                    .HasConstraintName("FK__TRAIN__MODEL_ID__32E0915F");

                entity.HasOne(d => d.ORG)
                    .WithMany(p => p.TRAIN)
                    .HasForeignKey(d => d.ORG_ID)
                    .HasConstraintName("FK__TRAIN__ORG_ID__31EC6D26");
            });

            modelBuilder.Entity<TRAVEL>(entity =>
            {
                entity.HasKey(e => e.TRAVEL_ID)
                    .HasName("PK__TRAVEL__6ED6E0590E404ADB");

                entity.Property(e => e.TRAVEL_ID).ValueGeneratedNever();

                entity.HasOne(d => d.DEST)
                    .WithMany(p => p.TRAVELDEST)
                    .HasForeignKey(d => d.DEST_ID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__TRAVEL__DEST_ID__36B12243");

                entity.HasOne(d => d.START)
                    .WithMany(p => p.TRAVELSTART)
                    .HasForeignKey(d => d.START_ID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__TRAVEL__START_ID__35BCFE0A");

                entity.HasOne(d => d.TRAIN)
                    .WithMany(p => p.TRAVEL)
                    .HasForeignKey(d => d.TRAIN_ID)
                    .HasConstraintName("FK__TRAVEL__TRAIN_ID__37A5467C");
            });

            modelBuilder.Entity<TRAVELFullView>(entity =>
            {
                entity.ToView("TRAVELFullView");
            });

            modelBuilder.Entity<TRAVELSTATION_VIEW>(entity =>
            {
                entity.ToView("TRAVELSTATION_VIEW");
            });

            modelBuilder.Entity<TRAVEL_STATION>(entity =>
            {
                entity.HasKey(e => new { e.TRAVEL_ID, e.STATION_ID })
                    .HasName("TS_ID");

                entity.HasOne(d => d.STATION)
                    .WithMany(p => p.TRAVEL_STATION)
                    .HasForeignKey(d => d.STATION_ID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__TRAVEL_ST__STATI__4316F928");

                entity.HasOne(d => d.TRAVEL)
                    .WithMany(p => p.TRAVEL_STATION)
                    .HasForeignKey(d => d.TRAVEL_ID)
                    .HasConstraintName("FK__TRAVEL_ST__TRAVE__4222D4EF");
            });

            modelBuilder.Entity<fullTrainView>(entity =>
            {
                entity.ToView("fullTrainView");
            });

            OnModelCreatingGeneratedProcedures(modelBuilder);
            OnModelCreatingGeneratedFunctions(modelBuilder);
            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}