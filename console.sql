select distinct client_types.display_name                 type,
                legal_entities.client_id                  crm_id,
                legal_entities.name                       legal_name,
                'Таджикистан'                             country,
                towns.name_rus                            city,
                npd_partner_client.npd_partner_id         npd_partner_id,
                (select addresses.body
                 from contacts
                          inner join addresses on contacts.id = addresses.contact_id
                 where contacts.client_id = clients.id
                                                          limit 1)                                 addresses,
                if(clients.id is not null, (select phones.body
                                            from phones
                                            where exists(select *
                                                         from contacts
                                                         where contacts.client_id = clients.id
                                                           and phones.contact_id = contacts.id
                                                           and phones.deleted_at is null)
                                            limit 1), '') phone,
                if(clients.id is not null, (select resident_statuses.is_resident
                                            from resident_statuses
                                            where resident_statuses.client_id = clients.id
                                            order by id desc
                                            limit 1), '') residential_status,
                clients.alif_branch_id                    branch_id,
                (select npd_stores.login
                 from npd_stores
                 where npd_stores.npd_partner_id = npd_partner_client.npd_partner_id
                   and npd_stores.login is not null
                 limit 1) as                              email,

                (select npd_stores.good_type_id
                 from npd_stores
                 where npd_stores.npd_partner_id = npd_partner_client.npd_partner_id
                 limit 1) as                              category,


                (select entrepreneur_certificates.certificate_id
                 from entrepreneur_certificates
                 where exists(select *
                              from documents as d
                              where d.id = entrepreneur_certificates.document_id
                                and d.client_id = clients.id
                                and d.document_type_id = 6
                                and d.document_status_id = 2
                                and d.deleted_at is null)
                 order by entrepreneur_certificates.id asc
                 limit 1)                                 certificate_number,

                (select entrepreneur_certificates.name
                 from entrepreneur_certificates
                 where exists(select *
                              from documents as d
                              where d.id = entrepreneur_certificates.document_id
                                and d.client_id = clients.id
                                and d.document_type_id = 6
                                and d.document_status_id = 2
                                and d.deleted_at is null)
                 order by entrepreneur_certificates.id asc
                 limit 1)                                 name,

                (select entrepreneur_certificates.surname
                 from entrepreneur_certificates
                 where exists(select *
                              from documents as d
                              where d.id = entrepreneur_certificates.document_id
                                and d.client_id = clients.id
                                and d.document_type_id = 6
                                and d.document_status_id = 2
                                and d.deleted_at is null)
                 order by entrepreneur_certificates.id asc
                 limit 1)                                 surname,

                (select entrepreneur_certificates.patronymic
                 from entrepreneur_certificates
                 where exists(select *
                              from documents as d
                              where d.id = entrepreneur_certificates.document_id
                                and d.client_id = clients.id
                                and d.document_type_id = 6
                                and d.document_status_id = 2
                                and d.deleted_at is null)
                 order by entrepreneur_certificates.id asc
                 limit 1)                                 patronymic,


                (select entrepreneur_certificates.date_of_issue
                 from entrepreneur_certificates
                 where exists(select *
                              from documents as d
                              where d.id = entrepreneur_certificates.document_id
                                and d.client_id = clients.id
                                and d.document_type_id = 6
                                and d.document_status_id = 2
                                and d.deleted_at is null)
                 order by entrepreneur_certificates.id asc
                 limit 1)                                 date_of_issue,


                (select entrepreneur_certificates.place_of_issue
                 from entrepreneur_certificates
                 where exists(select *
                              from documents as d
                              where d.id = entrepreneur_certificates.document_id
                                and d.client_id = clients.id
                                and d.document_type_id = 6
                                and d.document_status_id = 2
                                and d.deleted_at is null)
                 order by entrepreneur_certificates.id asc
                 limit 1)                                 place_of_issue,

                (select entrepreneur_certificates.note
                 from entrepreneur_certificates
                 where exists(select *
                              from documents as d
                              where d.id = entrepreneur_certificates.document_id
                                and d.client_id = clients.id
                                and d.document_type_id = 6
                                and d.document_status_id = 2
                                and d.deleted_at is null)
                 order by entrepreneur_certificates.id asc
                 limit 1)                                 ein
from legal_entities
    left join npd_partner_client on legal_entities.client_id = npd_partner_client.client_id
    left join clients on legal_entities.client_id = clients.id
    left join client_types on clients.client_type_id = client_types.id
    left join alif_branches on clients.alif_branch_id = alif_branches.id
    left join towns on clients.town_id = towns.id
where clients.deleted_at is null
order by crm_id;



select distinct client_types.display_name                 type,
                entrepreneurs.client_id                   crm_id,
                entrepreneurs.name                        legal_name,
                'Таджикистан'                             country,
                towns.name_rus                            city,
                npd_partner_client.npd_partner_id         npd_partner_id,
                (select addresses.body
                 from contacts
                          inner join addresses on contacts.id = addresses.contact_id
                 where contacts.client_id = clients.id limit 1) addresses,
                if(clients.id is not null, (select phones.body
                                            from phones
                                            where exists(select *
                                                         from contacts
                                                         where contacts.client_id = clients.id
                                                           and phones.contact_id = contacts.id
                                                           and phones.deleted_at is null)
                                            limit 1), '') phone,
                if(clients.id is not null, (select resident_statuses.is_resident
                                            from resident_statuses
                                            where resident_statuses.client_id = clients.id
                                            order by id desc
                                            limit 1), '') residential_status,
                clients.alif_branch_id                branch_id,

                (select npd_stores.login
                 from npd_stores
                 where npd_stores.npd_partner_id = npd_partner_client.npd_partner_id
                   and npd_stores.login is not null
                 limit 1) as                              email,

                (select npd_stores.good_type_id
                 from npd_stores
                 where npd_stores.npd_partner_id = npd_partner_client.npd_partner_id
                 limit 1) as                              category,

                (select entrepreneur_certificates.certificate_id
                 from entrepreneur_certificates
                          inner join documents as d on entrepreneur_certificates.document_id = d.id
                 where d.client_id = clients.id
                   and d.document_status_id = 2
                   and d.document_type_id = 6
                   and d.deleted_at is null
                 order by entrepreneur_certificates.id asc
                 limit 1)                                 certificate_number,

                (select entrepreneur_certificates.name
                 from entrepreneur_certificates
                          inner join documents as d on entrepreneur_certificates.document_id = d.id
                 where d.client_id = clients.id
                   and d.document_status_id = 2
                   and d.document_type_id = 6
                   and d.deleted_at is null
                 order by entrepreneur_certificates.id asc
                 limit 1)                                 name,

                (select entrepreneur_certificates.surname
                 from entrepreneur_certificates
                          inner join documents as d on entrepreneur_certificates.document_id = d.id
                 where d.client_id = clients.id
                   and d.document_status_id = 2
                   and d.document_type_id = 6
                   and d.deleted_at is null
                 order by entrepreneur_certificates.id asc
                 limit 1)                                 surname,

                (select entrepreneur_certificates.patronymic
                 from entrepreneur_certificates
                          inner join documents as d on entrepreneur_certificates.document_id = d.id
                 where d.client_id = clients.id
                   and d.document_status_id = 2
                   and d.document_type_id = 6
                   and d.deleted_at is null
                 order by entrepreneur_certificates.id asc
                 limit 1)                                 patronymic,

                (select entrepreneur_certificates.date_of_issue
                 from entrepreneur_certificates
                          inner join documents as d on entrepreneur_certificates.document_id = d.id
                 where d.client_id = clients.id
                   and d.document_status_id = 2
                   and d.document_type_id = 6
                   and d.deleted_at is null
                 order by entrepreneur_certificates.id asc
                 limit 1)                                 date_of_issue,

                (select entrepreneur_certificates.place_of_issue
                 from entrepreneur_certificates
                          inner join documents as d on entrepreneur_certificates.document_id = d.id
                 where d.client_id = clients.id
                   and d.document_status_id = 2
                   and d.document_type_id = 6
                   and d.deleted_at is null
                 order by entrepreneur_certificates.id asc
                 limit 1)                                 place_of_issue,

                (select entrepreneur_certificates.note
                 from entrepreneur_certificates
                          inner join documents as d on entrepreneur_certificates.document_id = d.id
                 where d.client_id = clients.id
                   and d.document_status_id = 2
                   and d.document_type_id = 6
                   and d.deleted_at is null
                 order by entrepreneur_certificates.id asc
                 limit 1)                                 ein
from entrepreneurs
    left join npd_partner_client on entrepreneurs.client_id = npd_partner_client.client_id
    left join clients on entrepreneurs.client_id = clients.id
    left join client_types on clients.client_type_id = client_types.id
    left join documents on clients.id = documents.client_id
    left join alif_branches on clients.alif_branch_id = alif_branches.id
    left join towns on clients.town_id = towns.id
where clients.deleted_at is null and documents.document_status_id = 2
order by crm_id;

# le + выписки
select documents.client_id,
       statements.fullname                                                                           full_name,
       statements.legal_entity_type                                                                  legal_entity_type,
       statements.address                                                                            address,
       statements.tin                                                                                tin,
       statements.sin                                                                                ein,
       statements.bik                                                                                bic,
       statements.date_of_foundation                                                                 date_of_foundation,
       statements.kind_of_activity                                                                   kind_of_activity,
       statements.registration_number                                                                registration_number,
       statements.entity_capital                                                                     capital,
       (select currencies.display_name from currencies where currencies.id = statements.currency_id) currency_code
from statements
         inner join documents on statements.document_id = documents.id
where documents.document_status_id = 2
  and documents.deleted_at is null
  and exists (select *
              from entrepreneurs
              where documents.client_id = entrepreneurs.client_id
                and entrepreneurs.deleted_at is null);


select documents.client_id,
       statements.fullname                                                                           full_name,
       statements.legal_entity_type                                                                  legal_entity_type,
       statements.address                                                                            address,
       statements.tin                                                                                tin,
       statements.sin                                                                                ein,
       statements.bik                                                                                bic,
       statements.date_of_foundation                                                                 date_of_foundation,
       statements.kind_of_activity                                                                   kind_of_activity,
       statements.registration_number                                                                registration_number,
       statements.entity_capital                                                                     capital,
       (select currencies.display_name from currencies where currencies.id = statements.currency_id) currency_code
from statements
         inner join documents on statements.document_id = documents.id
where documents.document_status_id = 2
  and documents.deleted_at is null
  and exists (select *
              from legal_entities
              where documents.client_id = legal_entities.client_id
                and legal_entities.deleted_at is null);



# le + лицензии
select legal_entities.client_id                   crm_id,
       licenses.number                            license_number,
       licenses.types_of_licensed_activities_list license_type,
       licenses.date_of_license_issue             date_of_issue,
       licenses.license_expiration_date           date_of_expiry,
       licenses.issued_by                         issued_by
from legal_entities
         inner join documents on legal_entities.client_id = documents.client_id
         inner join licenses on documents.id = licenses.document_id
where documents.deleted_at is null



select distinct entrepreneurs.client_id                                            crm_client_id,
                individuals.client_id                                              crm_represent_id,
                coalesce(concat(individuals.name, ' ', individuals.surname, ' ', individuals.patronymic),
                         concat(individuals.name, ' ', individuals.surname),
                         concat(individuals.name, ' ', individuals.patronymic)) as nameSurnamePatronymic,
                (select phones.body
                 from phones
                          inner join contacts
                                     on contacts.id = phones.contact_id and contacts.client_id = individuals.client_id
                 order by phones.is_main desc
                                                                                   limit 1)                                                       as phone
from entrepreneurs
    inner join individuals on entrepreneurs.individual_id = individuals.id
    inner join clients on individuals.client_id = clients.id
    inner join documents on clients.id = documents.client_id and documents.document_status_id = 2
where clients.deleted_at is null and documents.deleted_at is null;


select distinct legal_entities.client_id                                           crm_client_id,
                legal_entity_positions.display_name                                type,
                clients.id                                                         crm_represent_id,
                coalesce(concat(individuals.name, ' ', individuals.surname, ' ', individuals.patronymic),
                         concat(individuals.name, ' ', individuals.surname),
                         concat(individuals.name, ' ', individuals.patronymic)) as nameSurnamePatronymic,
                (select phones.body
                 from phones
                          inner join contacts
                                     on contacts.id = phones.contact_id and contacts.client_id = individuals.client_id
                 order by phones.is_main desc
                                                                                   limit 1)                                                       as phone,
                representatives.comment                                            comment
from legal_entities
    inner join representatives on legal_entities.id = representatives.legal_entity_id
    inner join legal_entity_positions on representatives.legal_entity_position_id = legal_entity_positions.id
    inner join individuals on representatives.individual_id = individuals.id
    inner join clients on individuals.client_id = clients.id
    inner join documents on clients.id = documents.client_id and documents.document_status_id = 2
where clients.deleted_at is null and documents.deleted_at is null and individuals.deleted_at is null




select salom_tranches.contract_number_id ContractNumber,
       applications.amount amount,
       light_products.contract_date ContractDate,
       users.name Name
from salom_tranches
         inner join products on salom_tranches.product_id = products.id
         inner join product_application on products.id = product_application.product_id
         inner join light_products on products.id = light_products.product_id
         inner join applications on product_application.application_id = applications.id
         inner join users on light_products.created_by_id = users.id
where light_products.created_at between '2023-01-01' and '2023-06-01'


select *
from delivery_points
where delivery_points.name not like 'deliver%'
  and delivery_points.branch_code_id is not null;



select application_subtypes.display_name PodTip,
       light_products.contract_number    ContractNumber,
       light_products.updated_at         ContractDate,
       salom_tranches.loan_amount        amount,
       products.user_signed_type         UserSignedType,
       application_subtypes.display_name SubType
from products
         inner join product_application on products.id = product_application.product_id
         inner join light_products on products.id = light_products.product_id
         inner join salom_tranches on products.id = salom_tranches.product_id
    and salom_tranches.contract_date between '2020-01-01' and '2023-08-28'
         inner join applications on product_application.application_id = applications.id
         inner join application_subtypes on applications.application_subtype_id = application_subtypes.id
         inner join product_statuses on products.product_status_id = product_statuses.id
order by salom_tranches.contract_date asc

SELECT towns.name_rus,
       salom_tranches.contract_date,
       light_products.client_name,
       clients.id                                                     as clientId,
       salom_tranches.loan_amount,
       currencies.display_name                                        as currencies,
       light_products.contract_number,
       product_types.display_name                                     as type,
       CONCAT('https://crm3.alif.tj/products/', products.id, '/page') as products,
       npd_stores.brand_name,
       product_statuses.display_name                                  as Status,
       products.id ProductId
FROM salom_tranches
         INNER JOIN products ON products.id = salom_tranches.product_id
         INNER JOIN light_products ON products.id = light_products.product_id
         INNER JOIN clients ON clients.id = products.client_id
         INNER JOIN currencies ON currencies.id = salom_tranches.currency_id
         INNER JOIN npd_conditions ON npd_conditions.id = salom_tranches.npd_condition_id
         INNER JOIN npd_stores ON npd_conditions.npd_store_id = npd_stores.id
         INNER JOIN product_types ON product_types.id = light_products.product_type_id
         INNER JOIN product_statuses ON product_statuses.id = light_products.product_status_id
         INNER JOIN towns ON towns.id = clients.town_id
         INNER JOIN product_application ON product_application.product_id = products.id
where salom_tranches.export_status_id = 3
  and light_products.product_status_id = 9;

select * from clients

SELECT towns.name_rus,
       salom_tranches.contract_date,
       light_products.client_name,
       clients.id                                                     as clientId,
       salom_tranches.loan_amount,
       currencies.display_name                                        as currencies,
       light_products.contract_number,
       product_types.display_name                                     as type,
       CONCAT('https://crm3.alif.tj/products/', products.id, '/page') as products,
       npd_stores.brand_name,
       product_statuses.display_name                                  as Status
FROM salom_tranches
         INNER JOIN products ON products.id = salom_tranches.product_id

         INNER JOIN light_products ON products.id = light_products.product_id
         INNER JOIN clients ON clients.id = products.client_id
         INNER JOIN currencies ON currencies.id = salom_tranches.currency_id
         INNER JOIN npd_conditions ON npd_conditions.id = salom_tranches.npd_condition_id
         INNER JOIN npd_stores ON npd_conditions.npd_store_id = npd_stores.id
         INNER JOIN product_types ON product_types.id = light_products.product_type_id
         INNER JOIN product_statuses ON product_statuses.id = light_products.product_status_id
         INNER JOIN towns ON towns.id = clients.town_id
         INNER JOIN product_application ON product_application.product_id = products.id
where salom_tranches.export_status_id = 3
  and light_products.product_status_id = 9;

select COALESCE(CONCAT(individuals.surname, ' ', individuals.name, ' ', individuals.patronymic),
                CONCAT(individuals.surname, ' ', individuals.name),
                CONCAT(individuals.surname, ' ', individuals.patronymic)) as ФИО,
       visa_cards.product_id ProductId,
       card_types.display_name CardType,
       product_statuses.display_name Status,
       visa_cards.contract_date ContractDate,
       contract_number ContractNumber,
       users.name UserName,
       towns.name_rus Towns,
       alif_branches.display_name Branches,
       'Visa' Product
from products
         inner join product_application on products.id = product_application.product_id
         inner join clients on products.client_id = clients.id
         inner join individuals on clients.id = individuals.client_id
         inner join product_statuses on products.product_status_id = product_statuses.id
         inner join visa_cards on visa_cards.product_id = products.id
         inner join alif_branches on products.alif_branch_id = alif_branches.id
         inner join users on users.id = products.user_signed_id
         inner join light_products on products.id = light_products.product_id
         inner join card_types on visa_cards.card_type_id = card_types.id
         inner join applications on product_application.application_id = applications.id
         inner join towns on applications.town_id = towns.id and towns.id in (2,17,30,24)
where products.product_status_id = 9
  and visa_cards.created_at between '2023-07-01' and '2023-08-30'
  and card_types.id != 1;


select users.name UserName,
       alif_branches.display_name Branches,
       'Korti Salom',
       products.id,
       light_products.contract_date
from products
         inner join users on products.user_signed_id = users.id
         inner join product_application on products.id = product_application.product_id
         inner join light_products on products.id = light_products.product_id
         inner join applications on product_application.application_id = applications.id
         inner join towns on applications.town_id = towns.id and towns.id in (2,17,30,24)
         inner join alif_branches on products.alif_branch_id = alif_branches.id
where light_products.contract_date between '2023-07-01' and '2023-08-30' and light_products.product_type_id = 20

select standart_credit_lines.contract_number_id ContractNumber,
       standart_credit_lines.contract_date ContractDate,
       standart_credit_lines.total_limit TotalLimit,
       standart_credit_lines.actual_limit ActualLimit,
       currencies.display_name Currency,
       product_statuses.display_name Status,
       products.client_id ClientID
from products
         inner join product_statuses on products.product_status_id = product_statuses.id
         inner join standart_credit_lines on products.id = standart_credit_lines.product_id
         inner join currencies on standart_credit_lines.currency_id = currencies.id

select light_products.contract_number as ContractNumber,
       questionnaires.income as Income,
       questionnaires.income_extra as ExtraIncome,
       c.display_name as IncomeCurrency,
       cur.display_name as ExtraIncomeCurrnecy,
       product_statuses.display_name as Status,
       concat('https://crm3.alif.tj/products/', products.id, '/page') as Link
from credit_applications
         inner join product_application on credit_applications.application_id = product_application.application_id
         inner join products on product_application.product_id = products.id
         inner join product_statuses on products.product_status_id = product_statuses.id and products.product_status_id = 9 and products.product_type_id not in (20, 6, 8, 16, 4)
         inner join light_products on products.id = light_products.product_id
         inner join clients on products.client_id = clients.id
         inner join questionnaires on clients.id = questionnaires.client_id
         left join currencies cur on questionnaires.income_extra_currency_id = cur.id
         left join currencies c on questionnaires.income_currency_id = c.id

select COALESCE(CONCAT(individuals.name, ' ', individuals.surname, ' ', individuals.patronymic),
                CONCAT(individuals.name, ' ', individuals.surname),
                CONCAT(individuals.name, ' ', individuals.patronymic)) as ФИО,
       light_products.product_id,
       light_products.contract_date,
       light_products.contract_number                                  as 'номер контракта',
        users.name,
       phones.body,
       towns.name_rus,
       alif_branches.display_name,
       'Deposit'
from clients
         inner join products on clients.id = products.client_id
         inner join light_products on products.id = light_products.product_id
         inner join contacts on clients.id = contacts.client_id
         inner join phones on contacts.id = phones.contact_id
         inner join individuals on clients.id = individuals.client_id
         inner join users on users.id = light_products.created_by_id and light_products.updated_by_type = 'users'
         inner join term_deposits on products.id = term_deposits.product_id
         inner join towns on clients.town_id = towns.id
         inner join alif_branches on products.alif_branch_id = alif_branches.id
    and phones.is_main = 1
    and products.product_status_id = 9
    and light_products.created_at between '2023-05-25' and '2023-09-01'
union
select COALESCE(CONCAT(individuals.name, ' ', individuals.surname, ' ', individuals.patronymic),
                CONCAT(individuals.name, ' ', individuals.surname),
                CONCAT(individuals.name, ' ', individuals.patronymic)) as ФИО,
       light_products.product_id,
       light_products.contract_date,
       light_products.contract_number                                  as 'номер контракта',
        users.name,
       phones.body,
       towns.name_rus,
       alif_branches.display_name,
       'Bank_accounts'
from clients
         inner join products on clients.id = products.client_id
         inner join light_products on products.id = light_products.product_id
         inner join contacts on clients.id = contacts.client_id
         inner join phones on contacts.id = phones.contact_id
         inner join individuals on clients.id = individuals.client_id
         inner join users on users.id = light_products.created_by_id and light_products.updated_by_type = 'users'
         inner join bank_accounts on products.id = bank_accounts.product_id
         inner join towns on clients.town_id = towns.id
         inner join alif_branches on products.alif_branch_id = alif_branches.id
    and phones.is_main = 1
    and products.product_status_id = 9
    and light_products.created_at between '2023-05-25' and '2023-09-01'