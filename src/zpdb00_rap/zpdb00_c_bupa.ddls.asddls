@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Simple Object with Projection'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZPDB00_C_BUPA
  provider contract transactional_query
  as projection on ZPDB00_R_BUPA
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
      //      @UI.lineItem: [{ position: 10,
      //                       importance: #HIGH }]
      //      @UI.identification: [{ position: 10, qualifier: 'PARTNER_INFO' }]
      //      @EndUserText.label: 'Partner'
      //      @EndUserText.quickInfo: 'Partner Number'
  key PartnerNo,
      //      @UI.selectionField : [ { position: 20 } ]
      //      @UI.lineItem: [{ position: 10,
      //                       importance: #HIGH }]
      //      @UI.identification: [{ position: 20, qualifier: 'PARTNER_INFO' }]
      //      @EndUserText.label: 'Partner Name'
      //      @EndUserText.quickInfo: 'Partner Name'
      Name,
      //      @UI.lineItem: [{ position: 30,
      //                       importance: #MEDIUM }]
      //      @UI.identification: [{ position: 30, qualifier: 'PARTNER_ADDR' }]
      //      @EndUserText.label: 'Street'
      //      @EndUserText.quickInfo: 'Street'
      Street,
      //      @UI.lineItem: [{ position: 40,
      //                       importance: #MEDIUM }]
      //      @UI.identification: [{ position: 40, qualifier: 'PARTNER_ADDR' }]
      //      @EndUserText.label: 'City'
      //      @EndUserText.quickInfo: 'City'
      City,
      //      @UI.lineItem: [{ position: 50,
      //                       importance: #MEDIUM }]
      //      @UI.identification: [{ position: 50, qualifier: 'PARTNER_ADDR' }]
      //      @EndUserText.label: 'Country'
      //      @EndUserText.quickInfo: 'Country Code'
      Country,
      //      @EndUserText.label: 'Currency'
      //      @EndUserText.quickInfo: 'Payment Currency'
      Currency,
            @Semantics.user.createdBy: true
      CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      CreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      ChangedBy,
      //local ETag field --> OData ETag
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      ChangedAt,
      //total ETag field
      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt
}
