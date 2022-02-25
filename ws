<?php

$pagina_detalhe = false;

$loop = new WP_Query(  array(  
  'post_type' => 'loteria'
) ); 

$loterias = '';
while ( $loop->have_posts() ) : $loop->the_post(); 
  $loterias .= get_the_ID().',';
endwhile;

get_header(); 

get_template_part("include/header");

?>

<style>
.page-title .title {
    margin-top: 0;
    font-weight: 700;
    color: #000;
    font-family: Ubuntu,sans-serif;
    font-size: 26px;
}
.page-title .sub-title {
    color: #111;
    font-size: 18px;
    font-family: Ubuntu,sans-serif;
    font-weight: 400;
}
</style>

<section class="section">

    <div class="container">

        <div class="mb-4 page-title " style="margin-bottom:20px" >
            <h1 class="title">Web Stories</h1>
            <h4 class="sub-title">
                <p>
                  <?php the_field('mensagem', 'option');  ?>
                </p>
            </h4>
        </div>


        <div class="row">
            <div class="col-md-8">

                <div class="left-column">

                    <section>
                        <h2 class="badge-title"><span>Ultimos Web Stories</span></h2>
                    </section>
                    <?php
                  if (have_posts()) :

                      while (have_posts() ) :the_post();
                          $id = get_the_ID();
                          $titulo = get_the_title();
                          $link = get_the_permalink();
                          $lottery = get_field('loteria', $id);    
                          $categoria_titulo = pegarTituloTagBuscas( $id );
                          $url_tag = pegarUrlTagBuscas( $id );

                          $imagem_id = get_post_thumbnail_id($id);
                          if (empty($imagem_id)) {
                              $imagem_id = 81;
                          }
                          $image_caption = get_post($imagem_id)->post_excerpt;
                          $image_title = get_post($imagem_id)->post_title;
                                                  
                          $thumbnail = wp_get_attachment_image_src($imagem_id, 'img-video-thumb' , true);

                          $comentarios = wp_count_comments($id);
                          ?>

                    <article class="row margin-bottom-20">
                        <div class="col-md-4">
                            <a href="<?php echo $link; ?>">
                                <img class="img-responsive w100" src="<?php echo $thumbnail[0]; ?>"
                                    alt="<?php echo $image_caption; ?>" title="<?php echo $image_title; ?>">
                            </a>
                        </div>
                        <div class="col-md-8">
                            <h4 class="title no-margin-top">
                                <a href="<?php echo $link; ?>">
                                    <?php echo $titulo; ?>
                                </a>
                            </h4>
                            <div class="clearfix margin-bottom-10">

                                <time class="date pull-left">
                                    <?php echo get_the_date('d \d\e F, Y'); ?>
                                </time>
                            </div>
                            <div class="text" style="  word-break: break-all;">
                                <?php echo get_the_excerpt(); ?>
                            </div>
                        </div>
                    </article>

                    <?php
                      endwhile;

                      $max   = intval( $wp_query->max_num_pages );

                      /** Add current page to the array */
                      if ( $paged >= 1 )
                          $links[] = $paged;

                      /** Add the pages around the current page to the array */
                      if ( $paged >= 3 ) {
                          $links[] = $paged - 1;
                          $links[] = $paged - 2;
                      }

                      if ( ( $paged + 2 ) <= $max ) {
                          $links[] = $paged + 2;
                          $links[] = $paged + 1;
                      }

                      echo '<div class="clearfix margin-top-20"><nav aria-label="Page navigation"><ul class="pagination">' . "\n";

                      /** Previous Post Link */
                      if ( get_previous_posts_link() ) {
                          printf( '<li><a href="%s#inicio" aria-label="Previous"><span aria-hidden="true"><i class="fa fa-chevron-left"></i></span></a></li>' . "\n", get_pagenum_link( $paged-1 ) );
                      } else {
                          print('<li class="disabled"><a href="#" aria-label="Previous"><span aria-hidden="true"><i class="fa fa-chevron-left"></i></span></a></li>'. "\n");
                      }


                      /** Link to first page, plus ellipses if necessary */
                      if ( ! in_array( 1, $links ) ) {
                          $class = 1 == $paged ? ' class="active"' : '';

                          printf( '<li%s><a href="%s#inicio">%s</a></li>' . "\n", $class, esc_url( get_pagenum_link( 1 ) ), '1' );

                          if ( ! in_array( 2, $links ) )
                              echo '<li><a href="#">...</a></li>';
                      }

                      /** Link to current page, plus 2 pages in either direction if necessary */
                      sort( $links );
                      foreach ( (array) $links as $link ) {
                          $class = $paged == $link ? ' class="active"' : '';
                          printf( '<li%s><a href="%s#inicio">%s</a></li>' . "\n", $class, esc_url( get_pagenum_link( $link ) ), $link );
                      }

                      /** Link to last page, plus ellipses if necessary */
                      if ( ! in_array( $max, $links ) ) {
                          if ( ! in_array( $max - 1, $links ) )
                              echo '<li><a href="#">...</a></li>' . "\n";

                          $class = $paged == $max ? ' class="active"' : '';
                          printf( '<li%s><a href="%s#inicio">%s</a></li>' . "\n", $class, esc_url( get_pagenum_link( $max ) ), $max );
                      }

                      /** Next Post Link */
                      if ( $max>$paged ) {
                          printf( '<li><a href="%s#inicio" aria-label="Next"><span aria-hidden="true"><i class="fa fa-chevron-right"></i></span></a></li>' . "\n", get_pagenum_link( $paged+1 ) );
                      } else {
                          print('<li class="disabled"><a href="#" aria-label="Next"><span aria-hidden="true"><i class="fa fa-chevron-right"></i></span></a></li>'. "\n");
                      }

                      echo '</ul></nav></div>' . "\n";


                  else : // Não possui posts

                      echo '<h4>Nenhum item foi encontrado com esses parâmetros</h4>';

                  endif;
          ?>

                </div>
            </div>

            <div class="col-md-4">

                <div class="right-column">
                    <?php 
              
              $shortcode = '[videodestaque titulo="Vídeo mais recente" loteria="" ]';

              echo do_shortcode($shortcode);

            ?>

                </div>

                <div class="right-column">
                    <?php 
            
                    $shortcode = '[mais-recentes-automatico titulo="Últimas Notícias da Loteria" qtd=7 tipo="noticias" loterias="' .$loterias. '" button_title="Ver mais notícias da loteria" button_link="/noticias/" ]';

                    echo do_shortcode($shortcode);

                    ?>
                </div>


            </div>


        </div>
    </div>
</section>

<?php
get_footer();
