@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RAP Demo- Simple Object'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZPDB00_R_BUPA
  as select from zpdb00_bupa
  // composition of target_data_source_name as _association_name
{
      //      @UI.facet      : [
      //                {
      //                  id         : 'Collection',
      //                  type       : #COLLECTION,
      //                  label      : 'Partner Collection'
      //                },
      //          {
      //          id         : 'PartnerFields',
      //          label      : 'Partner Information',
      //          type       : #IDENTIFICATION_REFERENCE,
      //          targetQualifier: 'PARTNER_INFO',
      //                parentId   : 'Collection'
      //        },
      //        {
      //          id         : 'PartnerAddress',
      //          label      : 'Address',
      //          type       : #IDENTIFICATION_REFERENCE,
      //          targetQualifier: 'PARTNER_ADDR',
      //               parentId   : 'Collection'
      //         }
      //        ]
      //      @UI.selectionField : [ { position: 10 } ]
      //      @UI.lineItem: [{ position: 20,
      //                       importance: #HIGH }]
      //      @UI.identification: [{ position: 10, qualifier: 'PARTNER_INFO' }]
      //      @EndUserText.label: 'Partner'
      //      @EndUserText.quickInfo: 'Partner Number'
  key partner  as PartnerNo,
      //      @UI.selectionField : [ { position: 20 } ]
      //      @UI.lineItem: [{ position: 10,
      //                       importance: #HIGH }]
      //      @UI.identification: [{ position: 20, qualifier: 'PARTNER_INFO' }]
      //      @EndUserText.label: 'Partner Name'
      //      @EndUserText.quickInfo: 'Partner Name'
      name     as Name,
      //      @UI.lineItem: [{ position: 30,
      //                       importance: #MEDIUM }]
      //      @UI.identification: [{ position: 30, qualifier: 'PARTNER_ADDR' }]
      //      @EndUserText.label: 'Street'
      //      @EndUserText.quickInfo: 'Street'
      street   as Street,
      //      @UI.lineItem: [{ position: 40,
      //                       importance: #MEDIUM }]
      //      @UI.identification: [{ position: 40, qualifier: 'PARTNER_ADDR' }]
      //      @EndUserText.label: 'City'
      //      @EndUserText.quickInfo: 'City'
      city     as City,
      //      @UI.lineItem: [{ position: 50,
      //                       importance: #MEDIUM }]
      //      @UI.identification: [{ position: 50, qualifier: 'PARTNER_ADDR' }]
      //      @EndUserText.label: 'Country'
      //      @EndUserText.quickInfo: 'Country Code'
      country  as Country,
      //      @EndUserText.label: 'Currency'
      //      @EndUserText.quickInfo: 'Payment Currency'
      currency as Currency,
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
      // _association_name // Make association public
}
