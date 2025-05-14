@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Team Interface'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #COMPOSITE
define view entity ZPDB00_I_TEAM
  as select from zpdb00_team
  association of many to one ZPDB00_I_TEAM as _Leader on _Leader.UserId = $projection.TeamLeader
{
  key user_id  as UserId,
      name     as PlayerName,
      email    as Email,
      team_pos as PlayerPos,
      score    as Score,
      team     as Team,
      leader   as TeamLeader,
      _Leader
}
