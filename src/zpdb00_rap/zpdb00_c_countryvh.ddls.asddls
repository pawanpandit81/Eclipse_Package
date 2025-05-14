@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Search Help of Country'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #BASIC
@Search.searchable: true
//@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZPDB00_C_CountryVH
  as select from I_Country
{
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
      @ObjectModel.text.element: [ 'Description' ]
  key Country,
      //      CountryThreeLetterISOCode,
      //      CountryThreeDigitISOCode,
      //      CountryISOCode,
      //      IsEuropeanUnionMember,
      //      BankAndBankInternalIDCheckRule,
      //      BankInternalIDLength,
      //      BankInternalIDCheckRule,
      //      BankNumberLength,
      //      BankCheckRule,
      //      BankAccountLength,
      //      BankPostalCheckRule,
      //      BankDataCheckIsCountrySpecific,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #LOW
      _Text[1: Language = $session.system_language].CountryName as Description,
      /* Associations */
      _Text
}
