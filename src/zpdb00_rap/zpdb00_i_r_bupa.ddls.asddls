@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RAP - Simple Object'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZPDB00_I_R_BUPA
  as select from zpdb00_bupa
  // composition of target_data_source_name as _association_name
{
      //      @UI.facet      : [
      //          {
      //            id         : 'Collection',
      //            type       : #COLLECTION,
      //            label      : 'Partner Collection'
      //          },
      //          {
      //          id         : 'FacetPartnerFields',
      //          label      : 'Partner Informations',
      //          type       : #IDENTIFICATION_REFERENCE,
      //          targetQualifier: 'PARTNER_INFO',
      //          parentId   : 'Collection'
      //        },
      //        {
      //          id         : 'FacetPartnerAddress',
      //          label      : 'Address',
      //          type       : #IDENTIFICATION_REFERENCE,
      //          targetQualifier: 'PARTNER_ADDR',
      //          parentId   : 'Collection'
      //         }
      //      ]
      //      @UI.selectionField : [ { position: 10 } ]
      //      @UI.lineItem: [{ position: 20, importance: #MEDIUM }]
      //      @EndUserText.label: 'Partner No.'
      //      @EndUserText.quickInfo: 'Partner Identifier'
  key partner          as Partner,
      //      @EndUserText.label: 'Partner Name'
      //      @EndUserText.quickInfo: 'Partner Name'
      //      @UI.identification: [{ position: 20, qualifier: 'PARTNER_INFO' }]
      //      @UI.selectionField : [ { position: 20 } ]
      //      @UI.lineItem: [{ position: 10, importance: #MEDIUM }]
      name             as Name,
      //      @EndUserText.label: 'Street'
      //      @EndUserText.quickInfo: 'Street and Housenumber'
      //      @UI.identification: [{ position: 30, qualifier: 'PARTNER_ADDR' }]
      //      @UI.lineItem: [{ position: 30, importance: #MEDIUM }]
      street           as Street,
      //      @EndUserText.label: 'City'
      //      @EndUserText.quickInfo: 'City of the Partner'
      //      @UI.lineItem: [{ position: 40, importance: #MEDIUM }]
      city             as City,
      //      @EndUserText.label: 'Ctry'
      //      @EndUserText.quickInfo: 'Country'
      //      @UI.lineItem: [{ position: 50, importance: #MEDIUM }]
      country          as Country,
      //      @EndUserText.label: 'Curr'
      //      @EndUserText.quickInfo: 'Payment currency'
      currency         as Currency,
      @Semantics.user.createdBy: true
      local_created_by as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      local_created_at as CreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by as ChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as ChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at  as LastChangedAt
      //   _association_name // Make association public
}
