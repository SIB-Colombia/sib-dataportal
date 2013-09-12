-- https://github.com/SIB-Colombia/sib-dataportal/wiki/Instructions-to-enable-common-names
/**
 * update the genera to be non accepted
 */
SET SQL_SAFE_UPDATES=0;
update portal.taxon_concept set is_accepted=false where rank=6000;


/**
 * update the genera to be accepted for any that are
 */
update 
    portal.taxon_concept pc 
        inner join portal.taxon_concept cc on cc.parent_concept_id = pc.id and cc.is_accepted=true
set pc.is_accepted=true
where pc.rank=6000;

/**
 * Update the denormalised part
 */
update portal.taxon_concept c
    inner join portal.taxon_concept p on c.phylum_concept_id = p.id
    inner join portal.taxon_name tn on p.taxon_name_id=tn.id
set
    c.phylum_concept_id = null
where 
    tn.canonical='Not assigned';

update portal.taxon_concept c
    inner join portal.taxon_concept cl on c.class_concept_id = cl.id
    inner join portal.taxon_name tn on cl.taxon_name_id=tn.id
set
    c.class_concept_id = null
where 
    tn.canonical='Not assigned';
    
update portal.taxon_concept c
    inner join portal.taxon_concept o on c.order_concept_id = o.id
    inner join portal.taxon_name tn on o.taxon_name_id=tn.id
set
    c.order_concept_id = null
where 
    tn.canonical='Not assigned';

update portal.taxon_concept c
    inner join portal.taxon_concept f on c.family_concept_id = f.id
    inner join portal.taxon_name tn on f.taxon_name_id=tn.id
set
    c.family_concept_id = null
where 
    tn.canonical='Not assigned';

/**
 * Now update the parents
 */ 
update 
    portal.taxon_concept c
        inner join portal.taxon_concept p on c.parent_concept_id=p.id
        inner join portal.taxon_name pn on p.taxon_name_id=pn.id
set
    c.parent_concept_id = p.parent_concept_id,
    c.phylum_concept_id=null
where 
    pn.canonical='Not assigned' and
    c.data_provider_id = @_data_provider_id and 
    p.rank=2000;    

update 
    portal.taxon_concept c
        inner join portal.taxon_concept p on c.parent_concept_id=p.id
        inner join portal.taxon_name pn on p.taxon_name_id=pn.id
set
    c.parent_concept_id = p.parent_concept_id,
    c.phylum_concept_id = p.phylum_concept_id,
    c.class_concept_id=null
where 
    pn.canonical='Not assigned' and
    c.data_provider_id = @_data_provider_id and  
    p.rank=3000;
    
update 
    portal.taxon_concept c
        inner join portal.taxon_concept p on c.parent_concept_id=p.id
        inner join portal.taxon_name pn on p.taxon_name_id=pn.id
set
    c.parent_concept_id = p.parent_concept_id,
    c.phylum_concept_id = p.phylum_concept_id,
    c.class_concept_id=p.class_concept_id,
    c.order_concept_id=null
where 
    pn.canonical='Not assigned' and
    c.data_provider_id = @_data_provider_id and  
    p.rank=4000;

update 
    portal.taxon_concept c
        inner join portal.taxon_concept p on c.parent_concept_id=p.id
        inner join portal.taxon_name pn on p.taxon_name_id=pn.id
set
    c.parent_concept_id = p.parent_concept_id,
    c.phylum_concept_id = p.phylum_concept_id,
    c.class_concept_id=p.class_concept_id,
    c.order_concept_id=p.order_concept_id,
    c.family_concept_id=null
where 
    pn.canonical='Not assigned' and
    c.data_provider_id = @_data_provider_id and  
    p.rank=5000;

update 
    portal.taxon_concept c
        inner join portal.taxon_concept p on c.parent_concept_id=p.id
        inner join portal.taxon_name pn on p.taxon_name_id=pn.id
set
    c.parent_concept_id = p.parent_concept_id,
    c.phylum_concept_id = p.phylum_concept_id,
    c.class_concept_id=p.class_concept_id,
    c.order_concept_id=p.order_concept_id,
    c.family_concept_id=p.family_concept_id,
    c.genus_concept_id=null
where 
    pn.canonical='Not assigned' and
    c.data_provider_id = @_data_provider_id and  
    p.rank=6000;

/**
* And delete the concepts
*/
   update portal.taxon_concept tc 
        inner join portal.taxon_name tn on tc.taxon_name_id=tn.id
set 
    kingdom_concept_id = null,
    phylum_concept_id = null,
    class_concept_id = null,
    order_concept_id = null,
    family_concept_id = null,
    genus_concept_id = null,
    species_concept_id = null
where
    tn.canonical='Not assigned';


delete 
    tc.* 
from portal.taxon_concept tc 
        inner join taxon_name tn on tc.taxon_name_id=tn.id
where 
    tn.canonical='Not assigned';
