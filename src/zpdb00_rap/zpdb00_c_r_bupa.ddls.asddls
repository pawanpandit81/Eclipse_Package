@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Simple Object with Projection'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@UI.headerInfo.title: { type: #STANDARD, value: 'Name' }
define root view entity ZPDB00_C_R_BUPA
  provider contract transactional_query
  as projection on ZPDB00_I_R_BUPA
{
  key Partner,
      Name,
      Street,
      City,
      Country,
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
