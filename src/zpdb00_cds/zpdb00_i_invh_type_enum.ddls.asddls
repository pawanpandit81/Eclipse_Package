@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice Header with Type and Enum'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #BASIC
define view entity ZPDB00_I_INVH_TYPE_ENUM
  as select from zpdb00_invh
{
  key document                                   as Document,
      doc_date                                   as DocDate,
      doc_time                                   as DocTime,
      partner                                    as Partner,
      cast( 'C' as ZPDB00_TYPE preserving type ) as StatusSimpleType,
      ZPDB00_TYPE_ENUM.#Payed                    as StatusEnumType
}
