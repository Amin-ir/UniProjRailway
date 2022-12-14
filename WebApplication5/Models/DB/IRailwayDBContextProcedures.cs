// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Data;
using System.Threading;
using System.Threading.Tasks;
using WebApplication5.Models.DB;

namespace WebApplication5.Models.DB
{
    public partial interface IRailwayDBContextProcedures
    {
        Task<List<CitySearchResult>> CitySearchAsync(int? PID, string PNAME, OutputParameter<int> returnValue = null, CancellationToken cancellationToken = default);
        Task<List<MEALTRAVEL_SEARCHResult>> MEALTRAVEL_SEARCHAsync(int? MID, string M_NAME, int? TID, OutputParameter<int> returnValue = null, CancellationToken cancellationToken = default);
        Task<List<StationSearchResult>> StationSearchAsync(int? pid, string pname, OutputParameter<int> returnValue = null, CancellationToken cancellationToken = default);
        Task<List<TICKETSEARCHResult>> TICKETSEARCHAsync(int? PID, string PSX, string PFNAME, string PLNAME, string PHONE, int? PWAGON, int? PCOUP, int? PSEAT, bool? PMEAL, DateTime? PSTARTTIME, DateTime? PARRIVALTIME, string STARTCITY, string DESTCITY, OutputParameter<int> returnValue = null, CancellationToken cancellationToken = default);
        Task<List<TrainSearchResult>> TrainSearchAsync(int? P_train_id, int? P_train_degree, int? P_coupe_capacity, int? p_coup_in_wagon, int? P_numof_wagon, int? P_org_id, string P_org_name, int? P_model_id, string P_model_name, OutputParameter<int> returnValue = null, CancellationToken cancellationToken = default);
        Task<List<TravelSearchResult>> TravelSearchAsync(int? pid, string pStartName, int? pStartId, string pDestName, int? pDestID, DateTime? pstartDate, DateTime? parrival, int? ptrainID, bool? twoSided, OutputParameter<int> returnValue = null, CancellationToken cancellationToken = default);
        Task<List<TRAVELSTATION_MODResult>> TRAVELSTATION_MODAsync(int? SID, string SNID, int? TID, OutputParameter<int> returnValue = null, CancellationToken cancellationToken = default);
        Task<List<UsersSearchResult>> UsersSearchAsync(int? p_id, DateTime? p_regDate, string p_fname, string p_lname, string p_sx, DateTime? p_birth, string p_phone, OutputParameter<int> returnValue = null, CancellationToken cancellationToken = default);
    }
}
